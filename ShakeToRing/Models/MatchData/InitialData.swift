//
//  InitialInfoModel.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/4/24.
//

import Foundation

struct InitialData : Codable {
    let cardEmojis : [String]
    let order : Int
    let cards : [Card]
}
