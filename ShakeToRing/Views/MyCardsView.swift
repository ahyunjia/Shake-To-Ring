//
//  MyCardsView.swift
//  Halli Galli
//
//  Created by An Hyunji on 7/23/24.
//

import SwiftUI

struct MyCardsView: View {
    var body: some View {
            NavigationView{
                ZStack {
                    Color(.orange)
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }.edgesIgnoringSafeArea(.all)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("add pressed")
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
        
        
        

    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView()
    }
}
