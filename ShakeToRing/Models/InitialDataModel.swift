//
//  InitialInfoModel.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/4/24.
//

import Foundation

struct InitialData : Codable {
    var cardEmojis : [String]?
    var order : Int?
    var cards : [Card]?
}
