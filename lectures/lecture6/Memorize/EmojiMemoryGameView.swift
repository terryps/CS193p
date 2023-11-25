//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/11/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var gameViewModel: EmojiMemoryGame
  
  var body: some View {
    VStack {
      ScrollView {
        cards
          .animation(.default, value: gameViewModel.cards)
      }
      Button("Shuffle") {
        gameViewModel.shuffle()
      }
    }
    .padding()
  }
  
  var cards: some View {
    // LazyVGrid uses as little spaces as it can.
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
      ForEach(gameViewModel.cards) { card in
        CardView(card)
          .aspectRatio(3/4, contentMode: .fit)
          .padding(4)
          .onTapGesture {
            gameViewModel.choose(card)
          }
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
