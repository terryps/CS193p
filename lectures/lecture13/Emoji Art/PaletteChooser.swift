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
      .clipped()
      // Views will draw outside their bounds all the time, like our background does
      // unless clipped().
    }
  
  private var chooser: some View {
    AnimatedActionButton(systemImage: "paintpalette") {
      store.cursorIndex += 1
    }
    .contextMenu {
      gotoMenu
      AnimatedActionButton("New", systemImage: "plus") {
        store.insert(name: "Math", emojis: "+-x%=")
      }
      AnimatedActionButton("Delete", systemImage: "minus") {
        store.palettes.remove(at: store.cursorIndex)
      }
    }
  }
  
  private var gotoMenu: some View {
    Menu {
      ForEach(store.palettes) { palette in
        AnimatedActionButton(palette.name) {
          if let index = store.palettes.firstIndex(where: { $0.id == palette.id }) {
            store.cursorIndex = index
          }
        }
      }
    } label: {
      Label("Go To", systemImage: "text.inset")
    }
  }
  
  func view(for palette: Palette) -> some View {
    HStack {
      Text(palette.name)
      ScrollingEmojis(palette.emojis)
    }
    .id(palette.id)
    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
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
