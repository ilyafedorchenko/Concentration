//
//  Concentration.swift
//  Concentration
//
//  Created by Илья Федорченко on 06/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

class Concentration {
  
  var cards = [Card]() {
    didSet {
      updateViewedCards()
    }
  }
  var score = 0
  private var indexOfOneAndOnlyFaceUpCard: Int?
  private var viewedCards: Set<Int> = []
  
  func startNewGame () {
    for index in 0..<cards.count {
      cards[index].isFaceUp = false
      cards[index].isMatched = false
    }
    viewedCards.removeAll()
    cards.shuffle()
  }
  
  private func updateViewedCards() {
    for card in cards {
      if card.isFaceUp {
        viewedCards.insert(card.identifier)
      }
    }
  }
  
  private func scoreCount(matchSucceed: Bool, mismatchIndexes: (Int, Int)?) {
    if !viewedCards.isEmpty {
      
      //TODO: finish this function
      
    }
  }
  
  func chooseCard(at index: Int) {
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        if cards[matchIndex].identifier == cards[index].identifier {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
          scoreCount(matchSucceed: true, mismatchIndexes: nil)
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = nil
        scoreCount(matchSucceed: false, mismatchIndexes: (index, matchIndex))
      } else {
        for flipDownIndex in cards.indices {
          cards[flipDownIndex].isFaceUp = false
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = index
      }
    }
  }
  
  init(numberOfPairsOfCards: Int) {
    for _ in 0..<numberOfPairsOfCards {
      let card = Card()
      cards += [card,card]
    }
    cards.shuffle()
  }
}
