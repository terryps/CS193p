//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/01.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var gameViewModel: EmojiMemoryGame
  
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    VStack {
      cards
        .animation(.default, value: gameViewModel.cards)

      Button("Shuffle") {
        gameViewModel.shuffle()
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
          gameViewModel.choose(card)
      }
    }
    .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  
  init(_ card: MemoryGame<String>.Card) {
    self.card = card
  }
  
  var body: some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
      
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 4)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(1, contentMode: .fit)
      }
      // .opacity(card.isFaceUp ? 1 : 0)
      base.fill().opacity(card.isFaceUp || card.isMatched ? 0 : 1)
    }
  }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(gameViewModel: EmojiMemoryGame())
    }
}
