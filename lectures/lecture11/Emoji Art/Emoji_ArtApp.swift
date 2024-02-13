//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/12.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
  @StateObject var defaultDocument = EmojiArtDocument()
  @StateObject var paletteStore = PaletteStore(named: "Main")
  
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
              // Get a thing of type PaletteStore that was injected into me.
              // This parameter only works when you hav one thing of a certain type that's passed down into a view hierarchy.
              .environmentObject(paletteStore)
        }
    }
}
