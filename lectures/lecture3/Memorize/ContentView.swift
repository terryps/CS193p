//
//  ContentView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/26.
//

import SwiftUI

struct ContentView: View {
  let emojis: Array<String> = ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🍄"]
  
  
  var body: some View {
    ScrollView {
      cards
    }
    .padding()
  }
  
  var cards: some View {
    // LazyVGrid uses as little spaces as it can.
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
      ForEach(emojis.indices, id: \.self) { i in
        CardView(content: emojis[i], isFaceUp: true)
          .aspectRatio(3/4, contentMode: .fit)
      }
    }
    .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
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
        base.strokeBorder(lineWidth: 4)
        Text(content).font(.largeTitle).frame(maxHeight: .infinity)
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
