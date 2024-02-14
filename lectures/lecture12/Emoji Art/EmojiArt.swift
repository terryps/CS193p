//
//  EmojiArt.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// MVVM - model

import Foundation

struct EmojiArt: Codable {
  var background: URL? = nil
  private(set) var emojis = [Emoji]()
  
  func json() throws -> Data {
    let encoded = try JSONEncoder().encode(self)
    print("EmojiArt = \(String(data: encoded, encoding: .utf8) ?? "nil")")
    return encoded
  }
  
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

  struct Emoji: Identifiable, Codable {
    // Emoji has to stay. Once its content decided, it doesn't change to something else.
    // So use let.
    let string: String
    var position: Position
    var size: Int
    var id: Int
    
    struct Position: Codable {
      var x: Int
      var y: Int
      
      static let zero = Self(x: 0, y: 0)
    }
  }
}
