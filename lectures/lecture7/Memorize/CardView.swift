//
//  CardView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/01.
//

import SwiftUI

struct CardView: View {
  typealias Card = MemoryGame<String>.Card
  
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

struct CardView_Previews: PreviewProvider {
  // This is the preview for the CardView.
  // So, it makes sense to alias that to be CardView.Card.
  typealias Card = CardView.Card
  
  static var previews: some View {
    CardView(Card(content: "X", id: "test1"))
  }
}
