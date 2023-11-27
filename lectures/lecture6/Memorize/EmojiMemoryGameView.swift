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
      cards
        .animation(.default, value: gameViewModel.cards)

      Button("Shuffle") {
        gameViewModel.shuffle()
      }
    }
    .padding()
  }
  
  var cards: some View {
    // LazyVGrid uses as little spaces as it can.
    GeometryReader { geometry in
      let gridItemSize = gridItemWidthThatFits(count: gameViewModel.cards.count, size: geometry.size, atAspectRatio: 2/3)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
        ForEach(gameViewModel.cards) { card in
          CardView(card)
            .aspectRatio(3/4, contentMode: .fit)
            .padding(4)
            .onTapGesture {
              gameViewModel.choose(card)
            }
        }
      }
    }
    .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
  }
  
  func gridItemWidthThatFits(
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
  ) -> CGFloat {
    let count = CGFloat(count)
    var columnCount = 1.0
    repeat {
      let width = size.width / columnCount
      let height = width / aspectRatio
      
      let rowCount = (count / columnCount).rounded(.up)
      if rowCount * height < size.height {
        return (size.width / columnCount).rounded(.down)
      }
      columnCount += 1
    } while columnCount < count
    return min(size.width / count, size.height * aspectRatio.rounded(.down))
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
