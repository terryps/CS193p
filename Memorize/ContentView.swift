//
//  ContentView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
  let emojis: Array<String> = ["🦋", "🪺", "🪻", "🦉"]
  
    var body: some View {
        HStack {
          ForEach(emojis.indices, id: \.self) { i in
            CardView(content: emojis[i], isFaceUp: true)
          }
        }
        .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
        .padding(.all)
    }
}

struct CardView: View {
  let content: String
  @State var isFaceUp: Bool = false
  
  var body: some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
      
      if isFaceUp{
        base.foregroundColor(.white)
        base.strokeBorder(lineWidth: 8)
        Text(content).font(.largeTitle)
      } else {
        base
      }
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
