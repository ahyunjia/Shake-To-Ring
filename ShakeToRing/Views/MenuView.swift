//
//  StartView.swift
//  Halli Galli
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.orange)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Text(matchManager.authenticationState.rawValue)
                        .foregroundColor(.white)
                    
                    Spacer()
                
                    VStack {
                        
                        Button{
                            matchManager.startMatchMaking()
                            
                        } label: {
                            Text("Play")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: 200)
                        }
                        .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .cornerRadius(13)
                            .disabled(!matchManager.localPlayer.isAuthenticated)
                        
                        NavigationLink(destination: MyCardsView()) {
                            Text("My Card Deck")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: 200)
                        }.buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .cornerRadius(13)
                        
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
.previewInterfaceOrientation(.portrait)
    }
}
