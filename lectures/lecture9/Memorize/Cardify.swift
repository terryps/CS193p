//
//  Cardify.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/13.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
  init(isFaceUp: Bool) {
    rotation = isFaceUp ? 0 : 180
  }
  
  var isFaceUp: Bool {
    rotation < 90
  }
  
  var rotation: Double
  
  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }
  
  func body(content: Content) -> some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.conrnerRadius)
      base.strokeBorder(lineWidth: Constants.lineWidth)
        .background(base.fill(.white))
        .overlay(content)
        .opacity(isFaceUp ? 1 : 0)
      
      base.fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
  }
  
  private struct Constants {
    static let conrnerRadius: CGFloat = 16
    static let lineWidth: CGFloat = 4
  }
}


extension View {
  func cardify(isFaceUp: Bool) -> some View {
    return self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
