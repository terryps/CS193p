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
  
  enum Focused {
    case name
    case addEmojis
  }
  
  // This state keeps track of which of the TextFields has the focus of the keyboard.
  // Oftentimes, this is a bool because you'll only have one TextField and it's either focus or not.
  // Since we have two TextFields, make focused be little Enum.
  // It has to be optional because neither of them might be focused.
  @FocusState private var focused: Focused?
  
  var body: some View {
    // Form is an extremely powerful VStack-like thing
    // for when you want to collect information from the user.
    Form {
      Section(header: Text("Name")) {
        TextField("Name", text: $palette.name)
        // Give TextField a binding to this little FocusState thing like that
        // and you tell it here it is name.
          .focused($focused, equals: .name)
      }
      Section(header: Text("Emojis")) {
        TextField("Add Emojis Here", text: $emojisToAdd)
          .focused($focused, equals: .addEmojis)
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
    .onAppear {
      if palette.name.isEmpty {
        focused = .name
      } else {
        focused = .addEmojis
      }
    }
  }
  
  private var removeEmojis: some View {
    VStack(alignment: .trailing) {
      Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
        ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
          Text(emoji)
            .onTapGesture {
              withAnimation {
                palette.emojis.remove(emoji.first!)
                emojisToAdd.remove(emoji.first!)
              }
            }
        }
      }
    }
    .font(emojiFont)
  }
}

//#Preview {
//    PaletteEditor()
//}
