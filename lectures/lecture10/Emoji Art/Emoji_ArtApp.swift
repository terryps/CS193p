//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
  @StateObject var defaultDocument = EmojiArtDocument()
  
  var body: some Scene {
    WindowGroup {
      EmojiArtDocumentView(document: defaultDocument)
    }
  }
}
