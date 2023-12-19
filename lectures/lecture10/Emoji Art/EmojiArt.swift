//
//  EmojiArt.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import Foundation

struct EmojiArt {
  var background: URL? = nil
  var emojis = [Emoji]()

  struct Emoji {
    let string: String
    var position: Position
    var size: Int
    
    struct Position {
      var x: Int
      var y: Int
    }
  }
}
