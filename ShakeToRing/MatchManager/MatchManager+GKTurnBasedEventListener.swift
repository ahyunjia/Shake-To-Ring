//
//  MatchManager+GKTurnBasedEventListener.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/1/24.
//

import Foundation
import GameKit

extension MatchManager: GKLocalPlayerListener {
    func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
        print("\(player.displayName)'s turn")
        
        let activeParticipants = match.participants.filter{ $0.status != .done }
        for participant in activeParticipants {
            print(participant.player?.displayName)
        }
        
        //At the beginning: determine distributor and distribute cards
        if !inGame && startOfMatch(match.creationDate){
            localRemainingCards = distributeCards(for: match, to: activeParticipants)
            inGame = true
            
            //show order for 10 seconds
        }
        
        //Player's state is active and has remining cards: flip cards
        if localRemainingCards.count > 0 || lastChance {
            
            myTurn = true
            currCard = localRemainingCards[0]
            myTurn = false
            //update remaining cards and flipped cards and total flipped cards
            //if shakable, wait till shake
        }
        
//        let nextParticipants = match.participants.filter{ $0 != match.currentParticipant }
//        match.endTurn(withNextParticipants: nextParticipants, turnTimeout: 90, match: Data(), completionHandler:{error in
//            if let error = error {
//                print(error)}})
    
    }
    
    func player(_ player: GKPlayer, receivedExchangeRequest exchange: GKTurnBasedExchange, for match: GKTurnBasedMatch) {
        
        let decoder = JSONDecoder()
        
        if !inGame {
            do {
                if let data = exchange.data {
                    let initialData = try decoder.decode(InitialData.self, from: data)
                    
                    cardEmojis = initialData.cardEmojis!
                    order = initialData.order!
                    localRemainingCards = initialData.cards!
                    inGame = true
                }
            } catch {
                print("not decodable")
            }
        }
        
        
        
    }
    
    //returns one deck of cards for the distributor
    func distributeCards(for match: GKTurnBasedMatch, to participants:[GKTurnBasedParticipant]) -> [Card] {
        let cardDeck = Constant.NEW_CARDDECK
        let numOfCards = Constant.TOTAL_CARDS / participants.count
        let splitCardDecks = cardDeck.chunked(into: numOfCards)
        let encoder = JSONEncoder()

        for idx in 1..<participants.count {
            
            do {
                let initialData = InitialData(cardEmojis: ["🥐", "🥯", "🍞", "🥨"], order: idx+1, cards: splitCardDecks[idx])
                let data = try encoder.encode(initialData)
                
                match.sendExchange(to: [participants[idx]], data: data, localizableMessageKey: "initialData", arguments: [], timeout: GKExchangeTimeoutNone)
            } catch {
                print("not encodable")
            }
        }
        
        return splitCardDecks[0]
    }
    
    func startOfMatch(_ matchStartTime: Date) -> Bool {
        let currentTime = Date()
        let timeSinceStart = currentTime.timeIntervalSince(matchStartTime)
        
        let threshold: TimeInterval = 10
        return timeSinceStart < threshold
    }
    
    func reorder() {
        
    }
    
    
}
