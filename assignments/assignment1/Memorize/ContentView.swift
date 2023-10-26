//
//  ContentView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/10/25.
//

import SwiftUI

enum Theme: Int {
  case mysticWoods
  case underTheSea
  case starryNight
}

struct ContentView: View {
  let emojis: [[String]] = [
    ["🦋", "🪺", "🏔️", "🦉", "🦊", "🐌", "🦎", "🐦‍⬛", "🍂", "🐝", "🫎", "🐿️", "🦡"],
    ["🪼", "🐠", "🐬", "🐡", "🪸", "🐚", "🌊", "🫧", "🧜🏽"],
    ["🌝", "🪐", "🌙", "✨", "🌟", "🌏"]
  ]
  
  @State var theme: Theme = Theme.mysticWoods
  @State var colCount: Int = 4
  
  var body: some View {
    VStack {
      Text("Memorize!").font(.largeTitle)
      cards
      // LazyVGrid uses as little spaces as it can.
      // Space is needed between cards & adjusters.
      Spacer()
      cardThemeAdjusters
    }
  }
  
  var cards: some View {
    var currEmojis: [String] = emojis[theme.rawValue]
    var emojiCount: Int = (currEmojis.count)*2
    var order: [Int] = Array(0..<emojiCount).shuffled()
    let colWidth: CGFloat = bestFitsColWidth(cardCount: emojiCount)

    // LazyVGrid uses as little spaces as it can.
    return ScrollView{
      LazyVGrid(columns: [GridItem(.adaptive(minimum: colWidth))]) {
        ForEach(order, id: \.self) { i in
          CardView(content: currEmojis[i/2], isFaceUp: true)
            .aspectRatio(3/4, contentMode: .fit)
        }
      }
      .foregroundColor(Color(hue: 0.442, saturation: 0.99, brightness: 0.985))
    }.padding()
  }
  
  var cardThemeAdjusters: some View {
    HStack(spacing: 20) {
      cardThemeAdjuster(number: Theme.mysticWoods, symbol: "tree", name: "Mystic\nwoods")
      cardThemeAdjuster(number: Theme.underTheSea, symbol: "water.waves", name: "Under\nthe sea")
      cardThemeAdjuster(number: Theme.starryNight, symbol: "moon.stars", name: "Starry\nnight")
    }
    .imageScale(.large)
  }
  
  func cardThemeAdjuster(number: Theme, symbol: String, name: String) -> some View {
    Button(action: {
      theme = number
    }, label: {
      VStack{
        // The system image tries to track the fonts of the things near.
        // The image scale is relative to the font size.
        Image(systemName: symbol)
          .frame(height: 50)
          .font(.title)
        Text(name)
      }
    })
    .disabled(theme==number)
  }
}

func bestFitsColWidth(cardCount: Int) -> CGFloat {
  switch cardCount {
    case 8...20:
      return 70
    default:
    return 54
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
