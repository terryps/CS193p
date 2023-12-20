//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import SwiftUI

struct EmojiArtDocumentView: View {
  private let emojis = "👣🧶🧵🪡🥿👞👢🧦🧤🧣💼🧳👓🥽🦉🦇🦋🐌🐞🐜🕷️🕸️🐍🦎🫏🐎🐏🐑🦙🐐🦌🐕🐈🐈‍⬛🪶🐓🪿🦆🐦‍⬛🦢🕊️🐇🦝🦡🦫🦦🐀🐿️🐾🌲🌳🌴🪵🌵🌱🌿☘️🍀🎍🪴🍃🍂🍁🪺🪹🍄🪨🌹🪻🪷🌺🌻🌞🌝🌔🪐☁️🔥🌈🌨️🍊🍋🍎🍇🍒🍑🥥🎂🍮🍯🥛🫖☕️🍵🥤🧃🍺🍷🥃🍸🍹🧉🍴🍽️🥡🥣"
  
  private let paletteEmojiSize: CGFloat = 40
  
  var body: some View {
    VStack(spacing: 0) {
      Color.black
      ScrollingEmojis(emojis)
        .font(.system(size: paletteEmojiSize))
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
  }
}

struct ScrollingEmojis: View {
  let emojis: [String]
  
  init(_ emojis: String) {
    // uniqued(extension): takes a string and removes all duplicates.
    self.emojis = emojis.uniqued.map(String.init)
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(emojis, id: \.self) { emoji in
          Text(emoji)
        }
      }
    }
  }
}

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView()
    }
}
