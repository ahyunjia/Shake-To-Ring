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
    @Published var notificationMsg:NotMsg = .shufflingCards
    
    @Published var inGame = false
    @Published var notifyGame = false
    @Published var isGameOver = false
    var cardEmojis = ["🍊", "🍉", "🍓", "🍈"]
    
    var match: GKMatch?
    var localPlayer = GKLocalPlayer.local
    var hostPlayer: GKPlayer?
    var playersNum = 0
    var order = 0
    var turn = 0
    var currShaker: GKPlayer?
    
    @Published var currCard:Card?
    @Published var localFlippedCards = [Card]()
    @Published var localRemainingCards = [Card]()
    
    var shakable = false
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
        
        if let matchmakingVC = GKMatchmakerViewController(matchRequest: request) {
            matchmakingVC.matchmakerDelegate = self
            matchmakingVC.matchmakingMode = .nearbyOnly
            
            rootViewController?.present(matchmakingVC, animated: true)
        }
    }
    
    func getReadyforGame(_ newMatch: GKMatch) {
        //set match, host of the match, distribute cards
        print(localPlayer.gamePlayerID)
        match = newMatch
        playersNum = newMatch.players.count + 1
        
        //update ui to game and loading
        DispatchQueue.main.async {
            self.inGame = true
            self.notificationMsg = .shufflingCards
            self.notifyGame = true
        }
        
        match?.delegate = self
        match?.chooseBestHostingPlayer { host in
            if let host = host {
                self.hostPlayer = host
                print(self.hostPlayer?.displayName)
                
                if host == self.localPlayer {
                    self.localRemainingCards = self.distributeCards(for: self.match!)
                    
                    DispatchQueue.main.async {
                        self.notificationMsg = .decideOrders
                        //after 10seconds, turn off not
                        self.notifyGame = false
                        self.myTurn = true
                    }
                }
            }
        }
        
    }
    
}
