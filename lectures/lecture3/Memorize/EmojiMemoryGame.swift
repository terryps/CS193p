//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/28.
//

import SwiftUI


// View Model
class EmojiMemoryGame: ObservableObject {
  // A property can be initialized by random order.
  // Initializing a property var with one another is impossible.
  // By adding 'static' to the front of it, it maked emojis global but namespace it inside of my class.
  // The global variables which is static will be initialized first.
  private static let emojis = ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🫎", "🐿️", "🍂", "🐦‍⬛"]
  
  // 1.
  // Access control -> prevent access from outside
  // private var gameModel: MemoryGame<String> = MemoryGame<String>()
  
  // 2.
  // private var gameModel = MemoryGame(
  //   numberOfPairsOfCards: 4,
  //   cardContentFactory: { index in
  //     return ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🫎", "🐿️", "🍂", "🐦‍⬛"][index]
  //   }
  // )
  
  // 3. If the last argument is to a function or creation, it can be put on the outside, trailing closure syntax.
  // private var gameModel = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
  //   return EmojiMemoryGame.emojis[pairIndex]
  // }
  
  // 4.
  // @Published : if this var changed, something is changed.
  @Published private var gameModel = EmojiMemoryGame.createMemoryGame()
  
  // Trying to use a function, a func in my class before I've even initialized my class.
  // Use 'static.'
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
