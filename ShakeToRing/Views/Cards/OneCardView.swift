//
//  OneCardView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/24/24.
//

import SwiftUI

struct OneCardView: View {
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
                Text(emoji)
                    .font(.system(size:100))
            }.padding(30)

        }
        .padding()
    }
}

//struct OneCardView_Previews: PreviewProvider {
//    @State private var icon = "🍐"
//
//    static var previews: some View {
//        OneCardView(icon: $icon)
//    }
//}
