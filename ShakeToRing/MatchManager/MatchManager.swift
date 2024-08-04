//
//  MatchManager.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/30/24.
//

import Foundation
import GameKit

class MatchManager: NSObject, ObservableObject {
    @Published var authenticationState:AuthState = .authenticating
    
    @Published var inGame = false
    @Published var pauseGame = false
    @Published var isGameOver = false
    var cardEmojis = ["🍊", "🍉", "🍓", "🍈"]
    
    var matchId: String = ""
    var localPlayer = GKLocalPlayer.local
    var order = 0
    
    @Published var currCard:Card?
    var localFlippedCards = [Card]()
    @Published var localRemainingCards = [Card]()
    var lastChance = true
    
    var shackable = false
    @Published var myTurn = false
    var totalFlippedCards = [0:0, 1:0, 2:0, 3:0]
    
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        localPlayer.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                return
            }
            
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                } else {
                    localPlayer.register(self)
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func startMatchMaking() {

        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 6
        
        let matchmakingVC = GKTurnBasedMatchmakerViewController(matchRequest: request)
        matchmakingVC.turnBasedMatchmakerDelegate = self
        matchmakingVC.matchmakingMode = .nearbyOnly
        matchmakingVC.showExistingMatches = false
        rootViewController?.present(matchmakingVC, animated: true)
        
//        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
//        matchmakingVC?.matchmakerDelegate = self
//        matchmakingVC?.matchmakingMode = .nearbyOnly
//        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func startGame(_ newMatch: GKTurnBasedMatch) {
        matchId = newMatch.matchID
    }
    
}
