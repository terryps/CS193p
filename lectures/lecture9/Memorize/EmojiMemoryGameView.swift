//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Yeojin Jung on 2023/12/13.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  typealias Card = MemoryGame<String>.Card
  @ObservedObject var gameViewModel: EmojiMemoryGame
  
  private let aspectRatio: CGFloat = 2/3
  private let spacing: CGFloat = 4
  
  var body: some View {
    VStack {
      cards
        .foregroundColor(gameViewModel.color)

      HStack {
        score
        Spacer()
        shuffle
      }
    }
    .padding()
  }
  
  private var score: some View {
    Text("Score: \(gameViewModel.score)")
      .animation(nil)
  }
  
  private var shuffle: some View {
    Button("Shuffle") {
      // withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.5))
      withAnimation {
        gameViewModel.shuffle()
      }
    }
  }
  
  private var cards: some View {
    AspectVGrid(gameViewModel.cards, aspectRatio: aspectRatio) { card in
      if isDealt(card) {
        CardView(card)
          .padding(spacing)
          .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
          .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
          .onTapGesture {
            choose(card)
          }
          .transition(.offset(
            x: 2000,
            y: -1000
          ))
      }
    }
    .onAppear {
      // deal the cards
      withAnimation(.easeInOut(duration: 2)) {
        for card in gameViewModel.cards {
          dealt.insert(card.id)
        }
      }
    }
  }
  
  @State private var dealt = Set<Card.ID>()
  
  private func isDealt(_ card: Card) -> Bool {
    dealt.contains(card.id)
  }
  
  private var undealtCards: [Card] {
    gameViewModel.cards.filter { !isDealt($0) }
  }
  
  private func choose(_ card: Card) {
    withAnimation {
      let scoreBeforeChoosing = gameViewModel.score
      gameViewModel.choose(card)
      let scoreAfterChoosing = gameViewModel.score - scoreBeforeChoosing
      lastScoreChange = (scoreAfterChoosing, card.id)
    }
  }
  
  // Card.ID: the Identifiable for the Card
  // @State private var lastScoreChange: (amount: Int, causedByCardId: Card.ID) = (amount: 0, causedByCardId: "")
  
  // We can omit type because we use Swift type inference.
  // @State private var lastScoreChange = (amount: 0, causedByCardId: "")
  
  // Tuples don't need names.
  @State private var lastScoreChange = (0, causedByCardId: "")
  
  private func scoreChange(causedBy card: Card) -> Int {
    // Getting the values out of a tuple, say let and variable names.
    let (amount, causedByCardId: id) = lastScoreChange
    
    return card.id == id ? amount : 0
    
    // Another way to access tuple stuff (not recommended)
    // This is pretty obscure to understand the syntax.
    // return lastScoreChange.1 == card.id ? lastScoreChange.0 : 0
  }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      EmojiMemoryGameView(gameViewModel: EmojiMemoryGame())
    }
}
