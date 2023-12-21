//
//  EmojiArtDocument.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

// MVVM - view model

import SwiftUI

class EmojiArtDocument: ObservableObject {
  typealias Emoji = EmojiArt.Emoji
  
  // Protect model from external access.
  @Published private var emojiArt = EmojiArt()
  
  init() {
    emojiArt.addEmoji("🌲", at: .init(x: -200, y: 200), size: 200)
    emojiArt.addEmoji("🦢", at: .init(x: 250, y: -150), size: 80)
  }
  
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


extension EmojiArt.Emoji {
  var font: Font {
    Font.system(size: CGFloat(size))
  }
}

extension EmojiArt.Emoji.Position {
  // Error: Keyword 'in' cannot be used as an identifier here
  // Fix: back quotes around 'in'
  func `in`(_ geometry: GeometryProxy) -> CGPoint {
    // local coordinate system of our View
    // center is an extension of CGRect
    let center = geometry.frame(in: .local).center
    return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
  }
}
