//
//  CardView.swift
//  Halli Galli
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI

struct FiveCardView: View {
    @Binding var emoji: String
    
    var body: some View {
        ZStack {
            
            VStack {}
            .cornerRadius(10)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
            )
            
            VStack {
                HStack {
                    Text(emoji)
                        .font(.system(size:100))
                    Spacer()
                    Text(emoji)
                        .font(.system(size:100))
                }
                Spacer()
                Text(emoji)
                    .font(.system(size:100))
                Spacer()
                HStack {
                    Text(emoji)
                        .font(.system(size:100))
                    Spacer()
                    Text(emoji)
                        .font(.system(size:100))
                }
            }.padding(30)
        }
        .padding()
            
    }
}

//struct FiveCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FiveCardView()
//    }
//}
