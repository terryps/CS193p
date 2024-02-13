//
//  PaletteChooser.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/13.
//

import SwiftUI

struct PaletteChooser: View {
  @EnvironmentObject var store: PaletteStore
  
    var body: some View {
      HStack {
        chooser
        view(for: store.palettes[store.cursorIndex])
      }
    }
  
  var chooser: some View {
    Button {
      store.cursorIndex += 1
    } label: {
      Image(systemName: "paintpalette")
    }
  }
  
  func view(for palette: Palette) -> some View {
    HStack {
      Text(palette.name)
      ScrollingEmojis(palette.emojis)
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
            .draggable(emoji)
        }
      }
    }
  }
}

#Preview {
    PaletteChooser()
      .environmentObject(PaletteStore(named: "Preview"))
}
