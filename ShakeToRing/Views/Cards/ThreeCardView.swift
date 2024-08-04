//
//  ThreeCardView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/24/24.
//

import SwiftUI

struct ThreeCardView: View {
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
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(emoji)
                        .font(.system(size:100))
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(emoji)
                        .font(.system(size:100))
                }
            }.padding(30)
        }.padding()
    }
}

//struct ThreeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThreeCardView()
//    }
//}
