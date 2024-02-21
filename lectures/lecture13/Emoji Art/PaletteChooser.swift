//
//  PaletteChooser.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/13.
//

import SwiftUI

struct PaletteChooser: View {
  @EnvironmentObject var store: PaletteStore
  
  @State private var showPaletteEditor = false
  @State private var showPaletteList = false
  
  var body: some View {
    HStack {
      chooser
      view(for: store.palettes[store.cursorIndex])
    }
    // Views will draw outside their bounds all the time, like our background does
    // unless clipped().
    .clipped()
    // isPresented: Boolean whether this sheet should be shown on the screen.
    // You can set isPresented by binding to showPaletteEditor.
    .sheet(isPresented: $showPaletteEditor) {
      // It's a ViewBuilder.
      PaletteEditor(palette: $store.palettes[store.cursorIndex])
        // Prob: PaletteEditor's fontsize is too big.
        // Sol: Stop using whatever setting on me. Go back to the default size.
        .font(nil)
    }
    .sheet(isPresented: $showPaletteList) {
      EditablePaletteList()
        .font(nil)
    }
  }
  
  private var chooser: some View {
    AnimatedActionButton(systemImage: "paintpalette") {
      store.cursorIndex += 1
    }
    .contextMenu {
      gotoMenu
      AnimatedActionButton("New", systemImage: "plus") {
        store.insert(name: "", emojis: "")
        showPaletteEditor = true
      }
      AnimatedActionButton("Edit", systemImage: "pencil") {
        showPaletteEditor = true
      }
      AnimatedActionButton("List", systemImage: "list.bullet.rectangle.portrait") {
        showPaletteList = true
      }
      AnimatedActionButton("Delete", systemImage: "minus.circle", role: .destructive) {
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
