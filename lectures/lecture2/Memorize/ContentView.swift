//
//  ContentView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
  let emojis: Array<String> = ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🍄"]
  
  @State var colCount: Int = 4
  
  var body: some View {
    VStack {
      cards
      // LazyVGrid uses as little spaces as it can.
      // Space is needed between cards & adjusters.
      Spacer()
      cardCountAdjusters
    }
    .padding()
  }
  
  var cards: some View {
    // LazyVGrid uses as little spaces as it can.
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
      ForEach(0..<colCount, id: \.self) { i in
        CardView(content: emojis[i], isFaceUp: true)
          .aspectRatio(3/4, contentMode: .fit)
      }
    }
    .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
  }
  
  var cardCountAdjusters: some View {
    HStack {
      cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
      Spacer()
      cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    .imageScale(.large)
    .font(.largeTitle)
  }
  
  func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
    Button(action: {
      colCount += offset
    }, label: {
      // The system image tries to track the fonts of the things near.
      // The image scale is relative to the font size.
      Image(systemName: symbol)
    })
    .disabled(colCount+offset < 1 || colCount+offset > emojis.count)
  }
}

struct CardView: View {
  let content: String
  @State var isFaceUp: Bool = false
  
  var body: some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
      
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 8)
        Text(content).font(.largeTitle)
      }
      base.fill().opacity(isFaceUp ? 0 : 1)
    }.onTapGesture {
      isFaceUp.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
