//
//  PaletteStore.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/13.
//

import SwiftUI

class PaletteStore: ObservableObject {
  let name: String
  @Published var palettes: [Palette] {
    didSet {
      if palettes.isEmpty, !oldValue.isEmpty {
        palettes = oldValue
      }
    }
  }
  
  init(named name: String) {
    self.name = name
    palettes = Palette.builtins
    if palettes.isEmpty {
      palettes = [Palette(name: "Warning", emojis: "⚠️")]
    }
  }
  
  // The view tracks one palette showing at one time.
  @Published private var _cursorIndex = 0
  
  var cursorIndex: Int {
    get { boundsCheckedPaletteIndex(_cursorIndex) }
    set { _cursorIndex = boundsCheckedPaletteIndex(newValue) }
  }
  
  // Prevent cursorIndex from out of bounds.
  private func boundsCheckedPaletteIndex(_ index: Int) -> Int {
    var index = index % palettes.count
    if index < 0 {
      index += palettes.count
    }
    return index
  }
}
