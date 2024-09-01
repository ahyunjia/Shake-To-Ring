//
//  GameNotificationView.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/6/24.
//

import SwiftUI

struct GameNotificationView: View {
    var msg:String?
    
    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0.8)
            Text(msg ?? "")
        }
    }
}

struct GameNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        GameNotificationView(msg:"shuffling cards")
    }
}
