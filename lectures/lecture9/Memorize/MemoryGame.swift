//
//  MemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/13.
//

import Foundation

//Model
struct MemoryGame<CardContent> where CardContent: Equatable {
  // private, but looking at the variable from external is allowed.
  private(set) var cards: Array<Card>
  private(set) var score = 0
  
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
            score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
          } else {
            if cards[chosenIndex].hasBeenSeen {
              score -= 1
            }
            if cards[potentialMatchIndex].hasBeenSeen {
              score -= 1
            }
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
    var isFaceUp = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
        if oldValue && !isFaceUp {
          hasBeenSeen = true
        }
      }
    }
    var hasBeenSeen = false
    var isMatched = false {
      didSet {
        if isMatched {
          stopUsingBonusTime()
        }
      }
    }
    var content: CardContent
    
    var id: String
    
    var debugDescription: String {
      return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
    }
    
    // MARK: - Bonus Time
    
    // can be zero which would mean "no bonus available" for matching this card quickly
    var bonusTimeLimit: TimeInterval = 6
    
    // the last time this card was turned face up
    var lastFaceUpDate: Date?
    
    // the accumulated time this card was face up in the past
    // (i.e. not including the current time it's been face up if it is currently so)
    var pastFaceUpTime: TimeInterval = 0
    
    // how long this card has ever been face up and unmatched during its lifetime
    // basically, pastFaceUpTime + time since lastFaceUpDate
    var faceUpTime: TimeInterval {
      if let lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    
    // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
    // this gets smaller and smaller the longer the card remains face up without being matched
    var bonus: Int {
        Int(bonusTimeLimit * bonusPercentRemaining)
    }
    
    // percentage of the bonus time remaining
    var bonusPercentRemaining: Double {
        bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
    }
    
    // call this when the card transitions to face up state
    private mutating func startUsingBonusTime() {
      if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      lastFaceUpDate = nil
    }
  }
}

extension Array {
  var only: Element? {
    count == 1 ? first : nil
  }
}
