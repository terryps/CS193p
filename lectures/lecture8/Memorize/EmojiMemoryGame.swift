//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/11.
//

import SwiftUI


// View Model
class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🫎", "🐿️", "🍂", "🐦‍⬛"]
  
  @Published private var gameModel = EmojiMemoryGame.createMemoryGame()

  static func createMemoryGame() -> MemoryGame<String> {
    return MemoryGame(numberOfPairsOfCards: 11) { pairIndex in
      if emojis.indices.contains(pairIndex){
        return emojis[pairIndex]
      } else {
        return "⁉️"
      }
    }
  }
  
  var cards: Array<Card> {
    gameModel.cards
  }
  
  var color: Color {
    Color(hue: 0.442, saturation: 0.99, brightness: 0.985)
  }
  
  // MARK: - Intents
  
  func shuffle() {
    gameModel.shuffle()
  }
  
  func choose(_ card: Card) {
    // intent function
    gameModel.choose(card)
  }
}
