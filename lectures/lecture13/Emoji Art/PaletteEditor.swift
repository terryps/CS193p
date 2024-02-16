//
//  PaletteEditor.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/16.
//

import SwiftUI

struct PaletteEditor: View {
  let palette: Palette
  
  var body: some View {
    // Form is an extremely powerful VStack-like thing
    // for when you want to collect information from the user.
    Form {
      Section(header: Text("Name")) {
        Text(palette.name)
      }
      Section(header: Text("Emojis")) {
        Text("Add Emojis Here")
        removeEmojis
      }
    }
    .frame(minWidth: 300, minHeight: 350)
  }
  
  private var removeEmojis: some View {
    VStack(alignment: .trailing) {
      Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
        ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
          Text(emoji)
        }
      }
    }
  }
}

//#Preview {
//    PaletteEditor()
//}
