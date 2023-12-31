//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/11/08.
//

import SwiftUI


// View Model
class EmojiMemoryGame: ObservableObject {
  private static let emojis = ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🫎", "🐿️", "🍂", "🐦‍⬛"]
  
  @Published private var gameModel = EmojiMemoryGame.createMemoryGame()

  static func createMemoryGame() -> MemoryGame<String> {
    return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
      if emojis.indices.contains(pairIndex){
        return emojis[pairIndex]
      } else {
        return "⁉️"
      }
    }
  }
  
  var cards: Array<MemoryGame<String>.Card> {
    return gameModel.cards
  }
  
  // MARK: - Intents
  
  func shuffle() {
    gameModel.shuffle()
  }
  
  func choose(_ card: MemoryGame<String>.Card) {
    // intent function
    gameModel.choose(card)
  }
}
