//
//  EmojiArt.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// MVVM - model

import Foundation

struct EmojiArt: Codable {
  var background: URL?
  private(set) var emojis = [Emoji]()
  
  func json() throws -> Data {
    let encoded = try JSONEncoder().encode(self)
    print("EmojiArt = \(String(data: encoded, encoding: .utf8) ?? "nil")")
    return encoded
  }
  
  init(json: Data) throws {
    self = try JSONDecoder().decode(EmojiArt.self, from: json)
  }
  
  // Error on EmojiArtDocument: Missing argument for parameter 'json' in call
  // Before adding an init(json: ), initializing background was optional. There was nothing to initialize.
  // So, init with no arguments worked.
  // But, now that there is an init(json: ), I lost the free one.
  // So, if we want that init with no arguments, we have to put it here.
  init() {}
  
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
