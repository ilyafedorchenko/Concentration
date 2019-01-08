//
//  ViewTheme.swift
//  Concentration
//
//  Created by Илья Федорченко on 08/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

struct CardVisualization {
  
  static var emojiRanges: [String:[String]] {
    
    let numberOfEmoji = 9
    var emojiRanges: [String:[String]] = ["":[]]
    
    func createEmojiRanges(total numberOfEmoji: Int, minOfRange: Int) -> [String] {
      var themeChars = [String]()
      for unicodeChar in minOfRange...minOfRange + numberOfEmoji {
        themeChars.append(String(Unicode.Scalar(unicodeChar)!))
      }
      return themeChars
    }
    
    let themeNames = ["Helloween", "Animals", "Sports", "Faces", "Food", "Entertainment"]
    for themeName in themeNames {
      switch themeName {
      case "Helloween":
        let emojiHelloween = ["🦇","😱","🎃","👻", "🙀", "😈", "🍭", "🍬", "🍎"]
        emojiRanges[themeName] = emojiHelloween
      case "Animals":
        emojiRanges[themeName] = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F42D)
      case "Sports":
        emojiRanges[themeName] = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F3C9)
      case "Faces":
        emojiRanges[themeName] = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F600)
      case "Food":
        emojiRanges[themeName] = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F354)
      case "Entertainment":
        emojiRanges[themeName] = createEmojiRanges(total: numberOfEmoji, minOfRange: 0x1F39E)
      default:
        print("Check switch in emojiRange variable")
        break
      }
    }
    return emojiRanges
  }
  
  static func getRandomThemeSet() -> ThemeSet {
    var themeSet = ThemeSet()
    let themeKeys = Array(emojiRanges.keys)
    let randomUpperbound = UInt32(themeKeys.count - 1)
    themeSet.themeName = themeKeys[Int(arc4random_uniform(randomUpperbound))]
    
    for emoji in emojiRanges[themeSet.themeName] ?? ["?"] {
      themeSet.cardTitleChoices.append(emoji)
    }
    return themeSet
  }
}

struct ThemeSet {
  var themeName = String()
  var cardTitleChoices = [String]()
  //  var faceBackgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  //  var backBackgroundColor: UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
  //  var faceBorderColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  //  var backBorderColor: UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
}
