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
            Color(.orange)
                .edgesIgnoringSafeArea(.all)
            
            //back button to disconnect from game
            
            VStack {
                
                if let card = matchManager.currCard {
                    
                    ZStack {
                        switch card.val {
                            
                        case 1:
                            OneCardView(emoji: $matchManager.cardEmojis[card.emojiId])
                                .frame(maxHeight: .infinity)
                        case 2:
                            TwoCardView(emoji: $matchManager.cardEmojis[card.emojiId])
                                .frame(maxHeight: .infinity)
                        case 3:
                            ThreeCardView(emoji: $matchManager.cardEmojis[card.emojiId])
                                .frame(maxHeight: .infinity)
                        case 4:
                            FourCardView(emoji: $matchManager.cardEmojis[card.emojiId])
                                .frame(maxHeight: .infinity)
                        case 5:
                            FiveCardView(emoji: $matchManager.cardEmojis[card.emojiId])
                                .frame(maxHeight: .infinity)
                        default:
                            Text("")
                        }

                        Circle()
                            .fill(.gray)
                            .frame(width: 60, height: 60)
                            .offset(x:-130, y: -150)
                    }
                } else {
                    ZStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 60, height: 60)
                            .offset(x:-130, y: -150)
                    }
                }
                
                Image("card_deck")
                    .resizable()
                    .scaledToFit()
            }.edgesIgnoringSafeArea(.bottom)
            
        }
    }
    
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(matchManager: MatchManager())
    }
}
