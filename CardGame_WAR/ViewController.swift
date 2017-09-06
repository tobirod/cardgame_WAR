//
//  ViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-01.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

public struct GameResult { // Struct used to store game results
    let winner: String
    let loser: String
    let winnerPoints: Int
    let loserPoints: Int
    var wasTied: Bool = false
}

class ViewController: UIViewController {
    
    let cards = [#imageLiteral(resourceName: "ace"), #imageLiteral(resourceName: "card2"), #imageLiteral(resourceName: "card3"), #imageLiteral(resourceName: "card4"), #imageLiteral(resourceName: "card5"), #imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card7"), #imageLiteral(resourceName: "card8"), #imageLiteral(resourceName: "card9"), #imageLiteral(resourceName: "card10"), #imageLiteral(resourceName: "jack"), #imageLiteral(resourceName: "queen"), #imageLiteral(resourceName: "king")]
    
    @IBOutlet weak var playerCard: UIImageView!
    @IBOutlet weak var houseCard: UIImageView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var playerScore: Int = 0
    var houseScore: Int = 0
    
    var gameTime: Int = 0 // in seconds
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetGame() // The game will reset every time we enter this view.
    }
    
    fileprivate func runTimer() {
        if !self.isTimerRunning {
            self.timerStackView.alpha = 1
            self.isTimerRunning = true
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    func updateTimer() {
        if self.gameTime > 0 {
            self.gameTime -= 1
            self.timerLabel.text = "\(gameTime)" + " seconds"
            
        } else {
            
            // Game time is 0 thus game over
            self.timer.invalidate()
            self.timerStackView.alpha = 0
            
            
            let gameResult = self.calculateWinner()
            self.performSegue(withIdentifier: "resultPopUp", sender: gameResult)
        }
    }
    
    fileprivate func calculateWinner() -> GameResult {
        // Set up game result struct where we store the results needed in PopUpViewController
        if self.playerScore > self.houseScore {
            return GameResult(winner: "Player", loser: "House", winnerPoints: self.playerScore, loserPoints: self.houseScore, wasTied: false)
        } else if houseScore > playerScore {
            return GameResult(winner: "House", loser: "Player", winnerPoints: self.houseScore, loserPoints: self.playerScore, wasTied: false)
        } else {
            return GameResult(winner: "", loser: "", winnerPoints: 0, loserPoints: 0, wasTied: true)
        }
    }
    
    fileprivate func resetGame() {
        self.gameTime = 10
        self.playerScore = 0
        self.houseScore = 0
        self.playerCard.image = #imageLiteral(resourceName: "back")
        self.houseCard.image = #imageLiteral(resourceName: "back")
        self.isTimerRunning = false
        self.timerLabel.text = "\(self.gameTime) seconds"
        self.playerLabel.text = "0"
        self.houseLabel.text = "0"
    }


    // MARK: - Actions
    
    @IBAction func dealButtonPressed(_ sender: UIButton) {
        
        self.runTimer()
        
        let playerNum = Int(arc4random_uniform(12))
        let houseNum = Int(arc4random_uniform(12))
        
        self.playerCard.image = self.cards[playerNum]
        self.houseCard.image = self.cards[houseNum]
        
        if playerNum > houseNum {
            self.playerScore += 1
            self.playerLabel.text = String(self.playerScore)
            
        } else if houseNum > playerNum {
            self.houseScore += 1
            self.houseLabel.text = String(self.houseScore)
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PopUpViewController, let gameResult = sender as? GameResult {
            vc.gameResult = gameResult
        }
    }
}

