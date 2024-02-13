//
//  Palette.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2024/02/13.
//

import Foundation

struct Palette: Identifiable {
  var name: String
  var emojis: String
  // UUID is a struct that generates an unique id.
  let id = UUID()
  
  static let builtins = [
    Palette(name: "Mammal", emojis: "🐒🦇🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🐂🐄🐎🐏🐑🦙🐐🦌🐕🐈🐈‍⬛🐇🦝🦨🦡🦫🦦🐿️🦔🐀"),
    Palette(name: "Bird", emojis: "🐣🐥🪿🦆🐦‍⬛🦅🦉🐓🦃🦤🦚🦜🦢🦩🕊️"),
    Palette(name: "Ocean", emojis: "🐙🦑🪼🦐🦞🦀🐡🐠🐟🐬🐳🐋🦈🦭🌊🪸"),
    Palette(name: "Flora", emojis: "🌵🌲🌳🌴🌱☘️🍀🌿🍄🌾🌷🌹🥀🪻🪷🌺"),
    Palette(name: "food", emojis: "🍎🍅🍊🍋🍈🫐🍇🍓🌽🥔🍞🥯🧀🥞🧇🥓🫓🥪🥙🧆🌮🫕🥫🍝")
  ]
}
