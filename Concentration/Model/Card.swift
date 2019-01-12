//
//  Card.swift
//  Concentration
//
//  Created by Илья Федорченко on 06/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

struct Card: Hashable {
  
  static func == (lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  var hashValue: Int {return identifier}
  
  var isFaceUp = false
  var isMatched = false
  private var identifier: Int
  
  private static var identifierFactory = 0
  private static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
  
}
