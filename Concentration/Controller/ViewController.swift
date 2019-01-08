//
//  ViewController.swift
//  Concentration
//
//  Created by Илья Федорченко on 05/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
  var themeSet = ThemeSet() {
    didSet {
      themeLabel.text = "\(themeSet.themeName)"
    }
  }
  
  var flipCount = 0 {
    didSet {
      flipCountLabel.text = "Flips: \(flipCount)"
    }
  }
  @IBOutlet var cardButtons: [UIButton]!
  
  @IBOutlet weak var flipCountLabel: UILabel!
  @IBOutlet weak var themeLabel: UILabel!
  
  @IBAction func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    } else {
      print("not in cardButtons")
    }
  }
  
  @IBAction func startNewGame(_ sender: UIButton) {
    flipCount = 0
    game.startNewGame()
    themeSet = CardVisualization.getRandomThemeSet()
    //FIXME: new theme buggy
    updateViewFromModel()
  }
  
  override func viewDidLoad() {
    themeSet = CardVisualization.getRandomThemeSet()
  }
  
  func updateViewFromModel() {
    for index in cardButtons.indices {
      
      let button = cardButtons[index]
      let card = game.cards[index]
      
      if card.isFaceUp {
        button.setTitle(emoji(for: card), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      } else {
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
      }
    }
  }
  
  var emoji = [Int:String]()
  
  func emoji (for card: Card) -> String {
    if emoji[card.identifier] == nil, themeSet.cardTitleChoices.count > 0 {
      let randomIndex = Int(arc4random_uniform(UInt32(themeSet.cardTitleChoices.count)))
      emoji[card.identifier] = themeSet.cardTitleChoices.remove(at: randomIndex)
    }
    return emoji[card.identifier] ?? "?"
  }
}
