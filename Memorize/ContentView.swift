//
//  ContentView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
          CardView(isFaceUp: true)
          CardView()
          CardView()
          CardView()
        }
        .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
        .padding(.all)
    }
}

struct CardView: View {
  var isFaceUp: Bool = false
  
  var body: some View {
    ZStack {
      if isFaceUp{
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.white)
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(lineWidth: 8)
        Text("🦋").font(.largeTitle)
      } else {
        RoundedRectangle(cornerRadius: 10)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
