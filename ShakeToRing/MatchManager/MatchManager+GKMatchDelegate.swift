//
//  MatchManager+GKMatchDelegate.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/4/24.
//

import Foundation
import GameKit

extension MatchManager: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        let startTime = DispatchTime.now()
        let type = decodeType(from: data)
        
        switch type {
            
        case .initialdata:
            print("received initial data")
            let data = MatchData<InitialData>.fromData(data)?.data
            if let initialData = data {
                setInitialData(initialData: initialData)
            }
            
            DispatchQueue.main.async {
    //            self.notificationMsg = .decideOrders
                //after 10seconds, turn of not
                self.notifyGame = false
            }
            
        case .flippedcardsdata:
            print("received card data")
            let data = MatchData<FlippedCardsData>.fromData(data)?.data
            if let cardsData = data {
                setFlippedCard(cards: cardsData)
            }
        
        //only received by hostplayer
        case .shakedata:
            print("received shake data")
            if localPlayer != hostPlayer || currShaker != nil {
                return
            }
            
            let data = MatchData<ShakeData>.fromData(data)?.data
            // player other than host shook
            if let shakeData = data {
                setShaker(shakeData)
                notifyShaker()
            }
        
        //only received by non-hostplayers
        case .shakerdata:
            print("received shaker data")
            let data = MatchData<ShakerData>.fromData(data)?.data
            if let shakerData = data {
                dealShakerResult(shakerData)
            }
            
        case .cardsdata:
            let data = MatchData<CardsData>.fromData(data)?.data
            if let cardsData = data {
                setCards(cardsData)
            }
        
        default:
            return
        }
        
        DispatchQueue.main.async {
//            self.notificationMsg = .decideOrders
            //after 10seconds, turn of not
//            self.notifyGame = false
        }
        let endTime = DispatchTime.now()
        print(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds)
    }
    
    private func decodeType(from data: Data) -> MatchDataType? {
        let decoder = JSONDecoder()
        let type = try? decoder.decode(DataType.self, from: data)
        return type?.type
    }
    
    private func setInitialData(initialData: InitialData) {
        cardEmojis = initialData.cardEmojis
        order = initialData.order
        localRemainingCards = initialData.cards
    }
    
    private func setFlippedCard(cards: FlippedCardsData) {
        totalFlippedCards = cards.flippedCards
        shakable = cards.shakable
        turn += 1
        turn %= playersNum
        myTurn = turn == order
    }
    
    private func setShaker(_ shake: ShakeData) {
        currShaker = match?.players[shake.idx]
        print("playerIdx: \(shake.idx)")
    }
    
    private func setCards(_ cardsData: CardsData) {
        DispatchQueue.main.async {
            self.localRemainingCards += cardsData.cards
            self.localRemainingCards.shuffle()
        }
    }
    
    func dealShakerResult(_ shaker: ShakerData) {
        DispatchQueue.main.async {
            
            print("deal shaker result")
            
            self.notifyGame = true
            
            if self.shakable {
                self.notificationMsg = .correctShaker
                self.totalFlippedCards = [0:0, 1:0, 2:0, 3:0]
                self.shakable = false
                
                
                if self.localPlayer.displayName != shaker.name {
                    print("i will award \(shaker.name)")
                    self.awardShaker(shakerName: shaker.name)
                }
                
                if self.localPlayer.displayName == shaker.name {
                    self.localRemainingCards += self.localFlippedCards
                    self.currCard = nil
                    self.localFlippedCards = []
                }
                
            } else {
                self.notificationMsg = .wrongShaker
                
                if self.localPlayer.displayName == shaker.name {
                    print("I will be penalized")
                    self.penalizeShaker()
                }
            }
            
            self.notifyGame = false
        }
        
        self.currShaker = nil
    }
}
