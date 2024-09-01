//
//  EmptyCardView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/19/24.
//

import SwiftUI

struct EmptyCardView: View {
    var body: some View {
        ZStack {
            
            VStack {}
            .cornerRadius(10)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.clear)
            )

        }
        .padding()
    }
}

struct EmptyCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCardView()
    }
}
