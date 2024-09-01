//
//  MatchManager+GameMethods.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/4/24.
//

import Foundation
import GameKit


extension MatchManager {
    
    //split cards, distribute cards, returns one deck of cards for the distributor
    func distributeCards(for match: GKMatch) -> [Card] {
        //split cards
        let cardDeck = Constant.NEW_CARDDECK
        let players = match.players
        let numOfCards = Constant.TOTAL_CARDS / playersNum
        
        let splitCardDecks = cardDeck.chunked(into: numOfCards)
        
        //send card deck to each player
        for idx in 0 ..< players.count {
            
            //make initalData
            let initialData = InitialData(cardEmojis: cardEmojis, order: idx+1, cards: splitCardDecks[idx+1])
            //put initialData in matchData, encode matchData into Data
            guard let matchData = MatchData(type: .initialdata, data: initialData).toData()
                else {
                print("initial data not encodable")
                return []}
            
            //send encoded data to each player
            do {
                try match.send(matchData, to: [players[idx]], dataMode: .reliable)
            } catch  {
                print("couldn't send initial data")
            }
        }
        
        //return the remaining card deck to the local player
        return splitCardDecks[0]
    }
    
    //update local player's card and total, shakable, send flipped card to other players
    func flipCard() {
        
        //delete the currCard (now old Card)
        if let oldCard = currCard {
            totalFlippedCards[oldCard.emojiId]! -= oldCard.val
            if totalFlippedCards[oldCard.emojiId]! == 5 {
                shakable = true
            }
        }
        
        //get new card from remaining deck
        let flippedCard = localRemainingCards.popLast()
        if let card = flippedCard {
            
            turn += 1
            turn %= playersNum
            //update ui
            DispatchQueue.main.async {
                self.currCard = card
                self.myTurn = self.turn == self.order
            }
            
            //add to flipped cards deck
            localFlippedCards.append(card)
            
            //update total count and shakable
            totalFlippedCards[card.emojiId]! += card.val
            if totalFlippedCards[card.emojiId]! == 5 {
                shakable = true
            }
            
            //put flippedCards in matchData, encode matchData into Data
            let newFlippedCardsData = FlippedCardsData(flippedCards: totalFlippedCards, shakable: shakable)
            guard let matchData = MatchData(type: .flippedcardsdata, data: newFlippedCardsData).toData()
                else {
                    print("flipped cards not encodable")
                    return
                }
            
            //send the encoded data to other players
            do {
                try match?.sendData(toAllPlayers: matchData, with: .reliable)
            } catch  {
                print("couldn't send card data")
            }
        }
        
        print("Shakable: \(shakable)")
    }
    
    func shake() {
        if notifyGame {
            print("notify: \(notifyGame)")
            return
        }
        // host shook
        if localPlayer == hostPlayer && currShaker == nil {
            print("host shook!")
            print(localPlayer)
            print(hostPlayer!)
            //set shaker
            currShaker = localPlayer
            notifyShaker()
            return
        }
        
        //player other than host shook
        let shakeData = ShakeData(idx: order-1)
        guard let matchData = MatchData(type: .shakedata, data: shakeData).toData()
        else {
            print("shake data not encodable")
            return
        }
        
        //send the encoded data to host
        do {
            try match?.send(matchData, to: [hostPlayer!], dataMode: .reliable)
        } catch  {
            print("couldn't send shake data")
        }
    }
    
    // only called from hostplayer
    func notifyShaker() {
        if let shaker = currShaker {
            
            let shakerData = ShakerData(id: shaker.gamePlayerID, name: shaker.displayName)
            
            guard let matchData = MatchData(type: .shakerdata, data: shakerData).toData()
                else {
                    print("shaker data not encodable")
                    return
                }
            
            //send the encoded data to other players
            do {
                try match?.sendData(toAllPlayers: matchData, with: .reliable)
            } catch  {
                print("couldn't send shaker data")
            }
            
            dealShakerResult(shakerData)
        }
    
    }
    
    
    func awardShaker(shakerName: String) {
        
        
        if let players = match?.players {
            for idx in 0 ..< players.count {
                print(players[idx])
                
                if players[idx].displayName == shakerName {
                    
                    let cardsData = CardsData(cards: localFlippedCards)
                    
                    guard let matchData = MatchData(type: .cardsdata, data: cardsData).toData()
                    else {
                        print("cards data not encodable")
                        return
                    }
                    
                    do {
                        try match?.send(matchData, to: [players[idx]], dataMode: .reliable)
                        
                        print("send card to \(players[idx].displayName)")
                    } catch  {
                        print("couldn't send cards data")
                    }
                    
                    DispatchQueue.main.async {
                        self.currCard = nil
                        self.localFlippedCards = []
                    }
                }
            }
        }
    }
    
    func penalizeShaker() {
        //if shaker's card < players' number game over
        if let players = match?.players {
            
            if players.count > localRemainingCards.count {
                //game over
                return
            }
            
            for idx in 0 ..< players.count {
                
                let cardsData = CardsData(cards: [localRemainingCards.popLast()!])
                
                guard let matchData = MatchData(type: .cardsdata, data: cardsData).toData()
                else {
                    print("cards data not encodable")
                    return
                }
                
                do {
                    try match?.send(matchData, to: [players[idx]], dataMode: .reliable)
                } catch  {
                    print("couldn't send cards data")
                }
            }
        }
    }
}
