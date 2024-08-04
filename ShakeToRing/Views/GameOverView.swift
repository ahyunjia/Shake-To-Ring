//
//  GameOverView.swift
//  Halli Galli
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        ZStack {
            Color(.blue)
                .edgesIgnoringSafeArea(.all)
            
            Text("You lost all your cards")
                .foregroundColor(.white)
            
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(matchManager: MatchManager())
    }
}
