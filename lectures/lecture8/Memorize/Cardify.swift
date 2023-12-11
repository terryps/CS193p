//
//  Cardify.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/11.
//

import SwiftUI

struct Cardify: ViewModifier {
  let isFaceUp: Bool
  let isMatched: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.conrnerRadius)
      
      base.strokeBorder(lineWidth: Constants.lineWidth)
        .background(base.fill(.white))
        .overlay(content)
      
      base.fill().opacity(isFaceUp || isMatched ? 0 : 1)
    }
    .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (0, 1, 0))
  }
  
  private struct Constants {
    static let conrnerRadius: CGFloat = 16
    static let lineWidth: CGFloat = 4
  }
}


extension View {
  func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
    return self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
  }
}
