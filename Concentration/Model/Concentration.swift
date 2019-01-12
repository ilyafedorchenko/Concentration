//
//  Concentration.swift
//  Concentration
//
//  Created by Илья Федорченко on 06/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

struct Concentration {
  
  private(set) var cards = [Card]()
  
  var score = 0
  var flipCount = 0
  private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
    }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }
  
  private var viewedCards: Set<Card> = []
  
  mutating func startNewGame () {
    for index in 0..<cards.count {
      cards[index].isFaceUp = false
      cards[index].isMatched = false
    }
    viewedCards.removeAll()
    score = 0
    cards.shuffle()
  }
  
  mutating private func updateViewedCards() {
    for card in cards {
      if card.isFaceUp {
        viewedCards.insert(card)
      }
    }
  }
  
  private mutating func penaltyCount(mismatchIndexes: (Card, Card)?) {
    if let mismatchIndexes = mismatchIndexes {
      let mismatchSet: Set<Card> = [mismatchIndexes.0, mismatchIndexes.1]
      let penaltyMultiplier = viewedCards.intersection(mismatchSet).count
      score +=  -penaltyMultiplier
    } else {
      score += 2
    }
  }
  
  mutating func chooseCard(at index: Int) {
    assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index no in the cards")
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        if cards[matchIndex] == cards[index] {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
          penaltyCount(mismatchIndexes: nil)
        } else {
          penaltyCount(mismatchIndexes: (cards[index], cards[matchIndex]))
        }
        cards[index].isFaceUp = true
        updateViewedCards()
      } else {
        flipCount += 1
        indexOfOneAndOnlyFaceUpCard = index
      }
    }
  }
  
  init(numberOfPairsOfCards: Int) {
    assert(numberOfPairsOfCards > 0, "Concentration.init(at:\(numberOfPairsOfCards)): you must have at least one pair of cards")
    for _ in 0..<numberOfPairsOfCards {
      let card = Card()
      cards += [card,card]
    }
    cards.shuffle()
  }
}

extension Collection {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}
