//
//  ViewTheme.swift
//  Concentration
//
//  Created by Илья Федорченко on 08/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

struct CardVisualization {
  
  var themeName: String = ""
  var themeCollection = [String]()
  
  private let numberOfEmoji = 9
  private let themeSets = [
    "Helloween":["🦇","😱","🎃","👻", "🙀", "😈", "🍭", "🍬", "🍎"],
    "Animals":[0x1F42D],
    "Sports":[0x1F3C9],
    "Faces":[0x1F600],
    "Food":[0x1F354],
    "Entertainment":[0x1F39E]
  ]
  
  private func createEmojiCollection(total numberOfEmoji: Int, minHexOfEmojiRange: Int) -> [String] {
    var themeChars = [String]()
    for unicodeChar in minHexOfEmojiRange...minHexOfEmojiRange + numberOfEmoji {
      themeChars.append(String(Unicode.Scalar(unicodeChar)!))
    }
    return themeChars
  }
  
  mutating func themeSetRandomlySwitched() {
    
//    let upperboundForRandomIndex = UInt32(themeSets.count)
//    let randomIndex = Int(arc4random_uniform(upperboundForRandomIndex))
    
    let themeNames = Array(themeSets.keys)
      themeName = themeNames[themeSets.count.arc4random]

    
    if let themeCollection = themeSets[themeName] as? [String] {
      self.themeCollection = themeCollection
    } else {
      let hexOfEmoji = themeSets[themeName] as! [Int]
      self.themeCollection = createEmojiCollection(total: numberOfEmoji, minHexOfEmojiRange: hexOfEmoji.first!)
    }
  }
}
