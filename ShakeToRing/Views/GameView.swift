//
//  GameView.swift
//  Halli Galli
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI
import UIKit

struct GameView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        ZStack {
            //call viewcontroller with viewcontroller wrapper
            ShakeDetector{matchManager.shake()}
            
            Color(.orange)
                .edgesIgnoringSafeArea(.all)
            
            //back button to disconnect from game
            
            VStack {
                ZStack {
                    CardView(card: $matchManager.currCard, cardEmojis: $matchManager.cardEmojis)
                    ZStack {
                        Text(String(matchManager.localFlippedCards.count))
                        Circle()
                            .fill(.gray)
                            .frame(width: 60, height: 60)
                            .offset(x:-130, y: -150)
                    }
                }
                
                ZStack {
                    Image("card_deck")
                        .resizable()
                        .scaledToFit()
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    let horizontal = value.translation.width
                                    let vertical = value.translation.height
                                    
                                    if matchManager.myTurn && !matchManager.shakable && vertical < 0 && abs(vertical) > abs(horizontal) {
                                        print("flipped")
                                        matchManager.flipCard()
                                    }
                                }
                        )
                    ZStack {
                        Text(String(matchManager.localRemainingCards.count))
                        Circle()
                            .fill(.gray)
                            .frame(width: 60, height: 60)
                            .offset(x:-130, y: -150)
                    }
                }
    
            }.edgesIgnoringSafeArea(.bottom)
            
            if matchManager.notifyGame {
                GameNotificationView(msg: matchManager.notificationMsg.rawValue)
            }
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(matchManager: MatchManager())
    }
}
