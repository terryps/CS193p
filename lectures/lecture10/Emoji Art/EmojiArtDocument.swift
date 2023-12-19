//
//  EmojiArtDocument.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// View model

import Foundation

class EmojiArtDocument: ObservableObject {
  typealias Emoji = EmojiArt.Emoji
  
  private var emojiArt = EmojiArt()
  
  var emojis: [Emoji] {
    emojiArt.emojis
  }
  
  var background: URL? {
    emojiArt.background
  }
  
  // MARK: - Intent(s)
  func setBackground(_ url: URL?) {
    emojiArt.background = url
  }
}
