//
//  CardView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/13.
//

import SwiftUI

struct CardView: View {
  typealias Card = MemoryGame<String>.Card
  
  let card: MemoryGame<String>.Card
  
  init(_ card: MemoryGame<String>.Card) {
    self.card = card
  }
    
  var body: some View {
    TimelineView(.animation(minimumInterval: 1/10)) { timeline in
      Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
        .opacity(Constants.Pie.opacity)
        .overlay(cardContents.padding(Constants.Pie.inset))
        .padding(Constants.inset)
        .cardify(isFaceUp: card.isFaceUp)
    }
  }
  
  var cardContents: some View {
    Text(card.content)
      .font(.system(size: Constants.FontSize.largest))
      .minimumScaleFactor(Constants.FontSize.scaleFactor)
      .multilineTextAlignment(.center)
      .aspectRatio(1, contentMode: .fit)
      .rotationEffect(.degrees(card.isMatched ? 360 : 0))
      .animation(.spin(duration: 1), value: card.isMatched)
  }
  
  // Namespaced all the constants used in CardView into "Constants" struct.
  private struct Constants {
    static let conrnerRadius: CGFloat = 16
    static let lineWidth: CGFloat = 4
    static let inset: CGFloat = 5
    struct FontSize {
      static let largest: CGFloat = 200
      static let smallest: CGFloat = 10
      static let scaleFactor = smallest / largest
    }
    struct Pie {
      static let opacity: CGFloat = 0.5
      static let inset: CGFloat = 5
    }
  }
}

extension Animation {
  static func spin(duration: TimeInterval) -> Animation {
    .linear(duration: 1).repeatForever(autoreverses: false)
  }
}

struct CardView_Previews: PreviewProvider {
  // This is the preview for the CardView.
  // So, it makes sense to alias that to be CardView.Card.
  typealias Card = CardView.Card
  
  static var previews: some View {
    VStack{
      HStack{
        CardView(Card(content: "X", id: "test1"))
        CardView(Card(isFaceUp: true, content: "X", id: "test2"))
      }
      HStack{
        CardView(Card(isMatched: true, content: "This is a very long string and I hope it fits.", id: "test1"))
        CardView(Card(isFaceUp: true, content: "X", id: "test2"))
      }
    }
  }
}
