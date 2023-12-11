//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var gameViewModel: EmojiMemoryGame
  
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    VStack {
      cards
        .foregroundColor(gameViewModel.color)

      Button("Shuffle") {
        // withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.5))
        withAnimation {
          gameViewModel.shuffle()
        }
      }
    }
    .padding()
  }
  
  private var cards: some View {
    AspectVGrid(gameViewModel.cards, aspectRatio: aspectRatio) { card in
      // Pass this view to AspectVGrid throung content argument.
      return CardView(card)
        .padding(4)
        .onTapGesture {
          withAnimation {
            gameViewModel.choose(card)
          }
      }
    }
  }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(gameViewModel: EmojiMemoryGame())
    }
}
