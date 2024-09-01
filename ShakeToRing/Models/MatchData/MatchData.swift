//
//  MatchData.swift
//  ShakeToRing
//
//  Created by An Hyunji on 8/8/24.
//

import Foundation

enum MatchDataType: Int, Codable {
    case initialdata
    case flippedcardsdata
    case shakedata
    case shakerdata
    case cardsdata
}

struct DataType: Decodable {
    var type: MatchDataType
}

struct MatchData<T: Codable>: Codable {
    
    var type: MatchDataType
    var data: T
    
    func toData() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
        
    static func fromData(_ data: Data) -> MatchData? {
        let decoder = JSONDecoder()
        return try? decoder.decode(MatchData.self, from: data)
    }
}
