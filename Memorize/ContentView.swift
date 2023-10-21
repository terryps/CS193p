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
  @State var isFaceUp: Bool = false
  
  var body: some View {
    ZStack {
      // The view is still struct.
      let base: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
      
      if isFaceUp{
        base.foregroundColor(.white)
        base.strokeBorder(lineWidth: 8)
        Text("🦋").font(.largeTitle)
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
