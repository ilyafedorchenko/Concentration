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
  var themeSet = CardVisualization() {
    didSet {
      themeLabel.text = "\(themeSet.themeName)"
    }
  }
  
  var flipCount = 0
  
  @IBOutlet var cardButtons: [UIButton]!
  @IBOutlet weak var flipCountLabel: UILabel!
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  @IBAction func touchCard(_ sender: UIButton) {
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    } else {
      print("not in cardButtons")
    }
  }
  
  @IBAction func startNewGame(_ sender: UIButton) {
    game.startNewGame()
    emoji.removeAll()
    themeSet.themeSetRandomlySwitched()
    updateViewFromModel()
  }
  
  override func viewDidLoad() {
    themeSet.themeSetRandomlySwitched()
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
    scoreLabel.text = "Score: \(game.score)"
    flipCountLabel.text = "Flips: \(game.flipCount)"
  }
  
  var emoji = [Int:String]()
  
  func emoji (for card: Card) -> String {
    if emoji[card.identifier] == nil, themeSet.themeCollection.count > 0 {
      let randomIndex = Int(arc4random_uniform(UInt32(themeSet.themeCollection.count)))
      emoji[card.identifier] = themeSet.themeCollection.remove(at: randomIndex)
    }
    return emoji[card.identifier] ?? "?"
  }
}
