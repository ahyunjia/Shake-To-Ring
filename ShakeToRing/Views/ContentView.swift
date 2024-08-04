//
//  ContentView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    
    var body: some View {
        ZStack {
            if matchManager.inGame {
                GameView(matchManager: matchManager)
            } else if matchManager.isGameOver {
                GameOverView(matchManager: matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        }.onAppear(perform: matchManager.authenticateUser)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
