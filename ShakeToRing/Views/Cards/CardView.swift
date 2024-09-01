//
//  CardView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/6/24.
//

import SwiftUI

struct CardView: View {
    @Binding var card:Card?
    @Binding var cardEmojis:[String]
    
    var body: some View {
        if let card = card {
            
            ZStack {
                switch card.val {
                    
                case 1:
                    OneCardView(emoji: $cardEmojis[card.emojiId])
                        .frame(maxHeight: .infinity)
                case 2:
                    TwoCardView(emoji: $cardEmojis[card.emojiId])
                        .frame(maxHeight: .infinity)
                case 3:
                    ThreeCardView(emoji: $cardEmojis[card.emojiId])
                        .frame(maxHeight: .infinity)
                case 4:
                    FourCardView(emoji: $cardEmojis[card.emojiId])
                        .frame(maxHeight: .infinity)
                case 5:
                    FiveCardView(emoji: $cardEmojis[card.emojiId])
                        .frame(maxHeight: .infinity)
                default:
                    Text("")
                }
            }

        } else {
            EmptyCardView()
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
