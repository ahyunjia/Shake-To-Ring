//
//  Constants.swift
//  ShakeToRing
//
//  Created by An Hyunji on 7/30/24.
//

struct Constant {
    static let MAX_PLAYER = 2
    static let MIN_PLAYER = 6
    static let TOTAL_CARDS = 56
    static var NEW_CARDDECK : [Card] {
        createCardDeck()
    }
}

func createCardDeck() -> [Card] {
    var cardDeck = [Card]()
    
    for emoji in 0...3 {
        
        for _ in 1...5 {
            cardDeck.append(Card(emojiId: emoji, val: 1))
        }
        
        for _ in 1...3 {
            cardDeck.append(Card(emojiId: emoji, val: 2))
        }
        
        for _ in 1...3 {
            cardDeck.append(Card(emojiId: emoji, val: 3))
        }
        
        for _ in 1...2 {
            cardDeck.append(Card(emojiId: emoji, val: 4))
        }
        
        for _ in 1...1 {
            cardDeck.append(Card(emojiId: emoji, val: 5))
        }
    }
    
    cardDeck.shuffle()
    return cardDeck
}

enum AuthState:String {
    case authenticating = "Signing into Game Center..."
    case unauthenticated = "You have to be signed in to play."
    case authenticated = "You are now ready to play !"
    case error = "An error occurred while signing in."
    case restricted = "Sorry, you aren't allowed to play a multiplayer game."
}

