//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by Yeojin Jung on 2023/12/19.
//

import SwiftUI

struct EmojiArtDocumentView: View {
  typealias Emoji = EmojiArt.Emoji
  
  @ObservedObject var document: EmojiArtDocument
  
  private let emojis = "👣🧶🧵🪡🥿👞👢🧦🧤🧣💼🧳👓🥽🦉🦇🦋🐌🐞🐜🕷️🕸️🐍🦎🫏🐎🐏🐑🦙🐐🦌🐕🐈🐈‍⬛🪶🐓🪿🦆🐦‍⬛🦢🕊️🐇🦝🦡🦫🦦🐀🐿️🐾🌲🌳🌴🪵🌵🌱🌿☘️🍀🎍🪴🍃🍂🍁🪺🪹🍄🪨🌹🪻🪷🌺🌻🌞🌝🌔🪐☁️🔥🌈🌨️🍊🍋🍎🍇🍒🍑🥥🎂🍮🍯🥛🫖☕️🍵🥤🧃🍺🍷🥃🍸🍹🧉🍴🍽️🥡🥣"
  
  private let paletteEmojiSize: CGFloat = 40
  
  var body: some View {
    VStack(spacing: 0) {
      documentBody
      PaletteChooser()
        .font(.system(size: paletteEmojiSize))
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
  }
  
  private var documentBody: some View {
    GeometryReader { geometry in
      ZStack {
        Color.white
        documentContents(in: geometry)
          .scaleEffect(zoom * gestureZoom)
          .offset(pan + gesturePan)
      }
      // add .gesture modifier to recognize gestures
      // .simultaneously tells the system that I want both of these gestures
      // to be recognized at the same time.
      .gesture(panGesture.simultaneously(with: zoomGesture))
      .dropDestination(for: Sturldata.self) { sturldatas, location in
        return drop(sturldatas, at: location, in: geometry)
      }
    }
  }
  
  // zoom and pan around on documentContents
  @State private var zoom: CGFloat = 1
  @State private var pan: CGOffset = .zero
  
  // Prob: Cannot see anything while dragging. After I let go dragging, it works.
  // I want to zoom while pinching.
  // Why? By the way, why is our zoom in @State, instead of being in our model or something?
  // Because zooming and panning in on the document is not part of an emoji document. It's how we're viewing it.
  @GestureState private var gestureZoom: CGFloat = 1
  @GestureState private var gesturePan: CGOffset = .zero
  
  private var zoomGesture: some Gesture {
    // By pinching the documentContents, it got twice as big or half as big or whatever.
    // It's going to change zoom by that much.
    MagnificationGesture()
      .updating($gestureZoom) { inMotionPinchScale, gestureZoom, _ in
        gestureZoom = inMotionPinchScale
      }
      .onEnded { endingPinchScale in
        // endingPinchScale(value): CGFloat
        zoom *= endingPinchScale
      }
  }
  
  private var panGesture: some Gesture {
    // Dragging means finger across the screen.
    DragGesture()
      .updating($gesturePan) { value, gesturePan, _ in
        gesturePan = value.translation
      }
      .onEnded { value in
        // pan: CGOffset has extension for +=.
        pan += value.translation
      }
  }
  
  @ViewBuilder
  private func documentContents(in geometry: GeometryProxy) -> some View {
    AsyncImage(url: document.background)
      .position(Emoji.Position(x: 0, y:0).in(geometry))
    ForEach(document.emojis) { emoji in
      Text(emoji.string)
        .font(emoji.font)
        .position(emoji.position.in(geometry))
    }
  }
  
  private func drop(_ sturldatas: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
    for sturldata in sturldatas {
      switch sturldata {
      case .url(let url):
        document.setBackground(url)
        return true
      case .string(let emoji):
        document.addEmoji(
          emoji,
          at: emojiPosition(at: location, in: geometry),
          size: paletteEmojiSize / zoom
        )
        return true
      default:
        break
      }
    }
    return false
  }
  
  private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
    let center = geometry.frame(in: .local).center
    return Emoji.Position(
      x: Int((location.x - center.x - pan.width) / zoom),
      y: Int(-(location.y - center.y - pan.height) / zoom)
    )
  }
}


struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiArtDocumentView(document: EmojiArtDocument())
        .environmentObject(PaletteStore(named: "Preview"))
    }
}
