//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/11/08.
//

import Foundation

//Model
struct MemoryGame<CardContent> where CardContent: Equatable {
  // private, but looking at the variable from external is allowed.
  private(set) var cards: Array<Card>
  
  init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    // Swift does type inference, it knows that "cards" is of type array of cards.
    cards = []
    // add numberOfPairsOfCards x 2 cards
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: "\(pairIndex+1)a"))
      cards.append(Card(content: content, id: "\(pairIndex+1)b"))
    }
  }
  
  func choose(_ card: Card) {}
  
  mutating func shuffle() {
    cards.shuffle()
    print(cards)
  }
  
  struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    var isFaceUp = true
    var isMatched = false
    var content: CardContent
    
    var id: String
    
    var debugDescription: String {
      return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
    }
  }
}
