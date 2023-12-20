//
//  EmojiArt.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// MVVM - model

import Foundation

struct EmojiArt {
  var background: URL? = nil
  private(set) var emojis = [Emoji]()
  
  private var uniqueEmojiId = 0
  
  mutating func addEmoji(_ emoji: String, at position: Emoji.Position, size: Int) {
    uniqueEmojiId += 1
    emojis.append(Emoji(
      string: emoji,
      position: position,
      size: size,
      id: uniqueEmojiId
    ))
  }

  struct Emoji: Identifiable {
    // Emoji has to stay. Once its content decided, it doesn't change to something else.
    // So use let.
    let string: String
    var position: Position
    var size: Int
    var id: Int
    
    struct Position {
      var x: Int
      var y: Int
    }
  }
}
