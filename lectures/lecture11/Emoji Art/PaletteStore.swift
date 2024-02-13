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
  
  // MARK: Adding Palettes
  
  // these functions are the recommended way to add Palettes to the PaletteStore
  // since they try to avoid duplication of Identifiable-ly identical Palettes
  // by first removing/replacing any Palette with the same id that is already in palettes
  // it does not "remedy" existing duplication, it just does not "cause" new duplication
  
  func insert(_ palette: Palette, at insertionIndex: Int? = nil) { // "at" default is cursorIndex
    let insertionIndex = boundsCheckedPaletteIndex(insertionIndex ?? cursorIndex)
    if let index = palettes.firstIndex(where: { $0.id == palette.id }) {
      palettes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
      palettes.replaceSubrange(insertionIndex...insertionIndex, with: [palette])
    } else {
      palettes.insert(palette, at: insertionIndex)
    }
  }
  
  func insert(name: String, emojis: String, at index: Int? = nil) {
    insert(Palette(name: name, emojis: emojis), at: index)
  }
  
  func append(_ palette: Palette) { // at end of palettes
    if let index = palettes.firstIndex(where: { $0.id == palette.id }) {
      if palettes.count == 1 {
        palettes = [palette]
      } else {
        palettes.remove(at: index)
        palettes.append(palette)
      }
    } else {
      palettes.append(palette)
    }
  }
  
  func append(name: String, emojis: String) {
    append(Palette(name: name, emojis: emojis))
  }
}
