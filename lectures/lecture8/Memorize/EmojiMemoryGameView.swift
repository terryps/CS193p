//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  typealias Card = MemoryGame<String>.Card
  @ObservedObject var gameViewModel: EmojiMemoryGame
  
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    VStack {
      cards
        .foregroundColor(gameViewModel.color)

      HStack {
        score
        Spacer()
        shuffle
      }
    }
    .padding()
  }
  
  private var score: some View {
    Text("Score: \(gameViewModel.score)")
      .animation(nil)
  }
  
  private var shuffle: some View {
    Button("Shuffle") {
      // withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.5))
      withAnimation {
        gameViewModel.shuffle()
      }
    }
  }
  
  private var cards: some View {
    AspectVGrid(gameViewModel.cards, aspectRatio: aspectRatio) { card in
      // Pass this view to AspectVGrid throung content argument.
      return CardView(card)
        .padding(4)
        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
        .onTapGesture {
          withAnimation {
            gameViewModel.choose(card)
          }
      }
    }
  }
  
  private func scoreChange(causedBy card: Card) -> Int {
    return 0
  }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(gameViewModel: EmojiMemoryGame())
    }
}
