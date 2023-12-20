//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import SwiftUI

struct EmojiArtDocumentView: View {
  private let emojis = ""
    var body: some View {
      VStack {
        Color.black
        ScrollingEmojis()
      }
    }
}

struct ScrollingEmojis: View {
  var body: some View {    
    ScrollView(.horizontal) {
    }
  }
}

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView()
    }
}
