//
//  Card.swift
//  Concentration
//
//  Created by Илья Федорченко on 06/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import Foundation

struct Card {
  
  var isFaceUp = false
  var isMatched = false
  var identifier: Int
  
  static var identifierFactory = 0
  static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
  
}
