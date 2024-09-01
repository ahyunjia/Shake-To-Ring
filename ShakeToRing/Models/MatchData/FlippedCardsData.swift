//
//  NewCardData.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/8/24.
//

import Foundation

struct FlippedCardsData: Codable {
    let flippedCards: [Int: Int]
    let shakable: Bool
}
