//
//  EmojiArtDocument.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// MVVM - view model

import Foundation

class EmojiArtDocument: ObservableObject {
  typealias Emoji = EmojiArt.Emoji
  
  // Protect model from external access.
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
  
  func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
    emojiArt.addEmoji(emoji, at: position, size: Int(size))
  }
}
