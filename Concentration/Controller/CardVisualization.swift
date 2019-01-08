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
  private let themeNames = ["Helloween", "Animals", "Sports", "Faces", "Food", "Entertainment", "Helloween", "Animals", "Sports", "Faces", "Food", "Entertainment"]
  
  private func createEmojiRanges(total numberOfEmoji: Int, minOfRange: Int) -> [String] {
    var themeChars = [String]()
    for unicodeChar in minOfRange...minOfRange + numberOfEmoji {
      themeChars.append(String(Unicode.Scalar(unicodeChar)!))
    }
    return themeChars
  }
  
  mutating func themeSetRandomlySwitched() {
    
    let randomUpperbound = UInt32(themeNames.count)
    var newThemeName = ""
    repeat {
      newThemeName = themeNames[Int(arc4random_uniform(randomUpperbound))]
    } while newThemeName == themeName
    themeName = newThemeName
    
    switch themeName {
    case "Helloween":
      themeCollection = ["🦇","😱","🎃","👻", "🙀", "😈", "🍭", "🍬", "🍎"]
    case "Animals":
      themeCollection = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F42D)
    case "Sports":
      themeCollection = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F3C9)
    case "Faces":
      themeCollection = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F600)
    case "Food":
      themeCollection = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F354)
    case "Entertainment":
      themeCollection = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F39E)
    default:
      print("Check switch in emojiRange variable")
      break
    }
  }
}
