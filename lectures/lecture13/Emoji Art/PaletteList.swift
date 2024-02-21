//
//  PaletteList.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/16.
//

import SwiftUI

struct PaletteList: View {
  // store that's been injected down into all of these @EnvironmentObject store.
  @EnvironmentObject var store: PaletteStore
  
  var body: some View {
    // Three pieces to navigation.
    // First of all, you're usually going to have a List, but you don't have to. You can navigate from anything.
    // The only thing is users are used to navigating from things in Lists.
    
    // 1. NavigationStack - surround everything that's happening in the navigation, which is the highest level.
    NavigationStack {
      // Anytime having a list of things, we're going to use a List.
      List(store.palettes) { palette in
        // List has its own built-in kind of ForEach thing.
        // 2. NavigationLink - UI that a user can touch on to navigate.
        NavigationLink(value: palette) {
          Text(palette.name)
        }
      }
      // 3. .navigationDestination
      .navigationDestination(for: Palette.self) { palette in
        // When the value of link is a palette, then below is what to do.
        PaletteView(palette: palette)
      }
      .navigationTitle("\(store.name) Palette")
    }
  }
}

struct PaletteView: View {
  let palette: Palette
  
  var body: some View {
    VStack {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
        ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
          NavigationLink(value: emoji) {
            Text(emoji)
          }
        }
      }
      .navigationDestination(for: String.self) { emoji in
        Text(emoji).font(.system(size: 300))
      }
      Spacer()
    }
    .padding()
    .font(.largeTitle)
    .navigationTitle(palette.name) // the title at the top of the NavigationStack
  }
}

#Preview {
    PaletteList()
}
