//
//  PaletteEditor.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/16.
//

import SwiftUI

struct PaletteEditor: View {
  @Binding var palette: Palette
  
  private let emojiFont = Font.system(size: 40)
  
  @State private var emojisToAdd: String = ""
  
  var body: some View {
    // Form is an extremely powerful VStack-like thing
    // for when you want to collect information from the user.
    Form {
      Section(header: Text("Name")) {
        TextField("Name", text: $palette.name)
      }
      Section(header: Text("Emojis")) {
        TextField("Add Emojis Here", text: $emojisToAdd)
          .font(emojiFont)
          .onChange(of: emojisToAdd) {
            // This palette is in ViewModel. In other words, I'm changing the ViewModel right here.
            palette.emojis = (emojisToAdd + palette.emojis)
              .filter { $0.isEmoji }
              .uniqued
          }
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
    .font(emojiFont)
  }
}

//#Preview {
//    PaletteEditor()
//}
