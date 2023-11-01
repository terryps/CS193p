//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/26.
//

import SwiftUI

@main
struct MemorizeApp: App {
  @StateObject var game = EmojiMemoryGame()
  var body: some Scene {
    WindowGroup {
      EmojiMemoryGameView(gameViewModel: game)
    }
  }
}
