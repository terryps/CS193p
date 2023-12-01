//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/01.
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
  
  var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { index in cards[index].isFaceUp }.only }
    set {
      // A closure that sets the binding value. The closure has the following parameter:
      // • newValue: The new value of the binding value.
      cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
    }
  }
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
      if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
          if cards[chosenIndex].content == cards[potentialMatchIndex].content {
            cards[chosenIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
          }
        } else {
          indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        
        cards[chosenIndex].isFaceUp = true
      }
    }
  }
  
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

extension Array {
  var only: Element? {
    count == 1 ? first : nil
  }
}
