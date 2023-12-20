//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import SwiftUI

struct EmojiArtDocumentView: View {
  private let emojis = "👣🧶🧵🪡🥿👞👢🧦🧤🧣💼🧳👓🥽🦉🦇🦋🐌🐞🐜🕷️🕸️🐍🦎🫏🐎🐏🐑🦙🐐🦌🐕🐈🐈‍⬛🪶🐓🪿🦆🐦‍⬛🦢🕊️🐇🦝🦡🦫🦦🐀🐿️🐾🌲🌳🌴🪵🌵🌱🌿☘️🍀🎍🪴🍃🍂🍁🪺🪹🍄🪨🌹🪻🪷🌺🌻🌞🌝🌔🪐☁️🔥🌈🌨️🍊🍋🍎🍇🍒🍑🥥🎂🍮🍯🥛🫖☕️🍵🥤🧃🍺🍷🥃🍸🍹🧉🍴🍽️🥡🥣"
  
    var body: some View {
      VStack {
        Color.black
        ScrollingEmojis(emojis)
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
