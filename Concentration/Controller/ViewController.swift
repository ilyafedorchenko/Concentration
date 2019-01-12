//
//  ViewController.swift
//  Concentration
//
//  Created by Илья Федорченко on 05/01/2019.
//  Copyright © 2019 Илья Федорченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  
  var numberOfPairsOfCards: Int {
    return (cardButtons.count + 1) / 2
  }
  var themeSet = CardVisualization() {
    didSet {
      themeLabel.text = "\(themeSet.themeName)"
    }
  }
  
  var flipCount = 0
  
  @IBOutlet private var cardButtons: [UIButton]!
  @IBOutlet private weak var flipCountLabel: UILabel! {
    didSet {
      updateFlipCountLabel()
    }
  }
  @IBOutlet private weak var themeLabel: UILabel!
  @IBOutlet private weak var scoreLabel: UILabel!
  
  @IBAction private func touchCard(_ sender: UIButton) {
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    } else {
      print("not in cardButtons")
    }
  }
  
  @IBAction private func startNewGame(_ sender: UIButton) {
    game.startNewGame()
    emoji.removeAll()
    themeSet.themeSetRandomlySwitched()
    updateViewFromModel()
  }
  
  override func viewDidLoad() {
    themeSet.themeSetRandomlySwitched()
  }
  
  private func updateFlipCountLabel() {
    let attributes: [NSAttributedString.Key:Any] = [
      NSAttributedString.Key.strokeWidth : 5.0,
      NSAttributedString.Key.strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
      ]
    let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
    flipCountLabel.attributedText = attributedString
  }
  
  private func updateViewFromModel() {
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
    scoreLabel.text = "Score: \(game.score)"
    updateFlipCountLabel()
  }
  
  private var emoji = [Card:String]()
  
  private func emoji (for card: Card) -> String {
    if emoji[card] == nil, themeSet.themeCollection.count > 0 {
      emoji[card] = themeSet.themeCollection.remove(at: themeSet.themeCollection.count.arc4random)
    }
    return emoji[card] ?? "?"
  }
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return -Int(arc4random_uniform(UInt32(abs(self))))
    } else {
      return 0
    }
  }
}
