//
//  ViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-01.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cardArray = [#imageLiteral(resourceName: "ace"), #imageLiteral(resourceName: "card2"), #imageLiteral(resourceName: "card3"), #imageLiteral(resourceName: "card4"), #imageLiteral(resourceName: "card5"), #imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card7"), #imageLiteral(resourceName: "card8"), #imageLiteral(resourceName: "card9"), #imageLiteral(resourceName: "card10"), #imageLiteral(resourceName: "jack"), #imageLiteral(resourceName: "queen"), #imageLiteral(resourceName: "king")]
    
    @IBOutlet weak var playerCard: UIImageView!
    
    @IBOutlet weak var houseCard: UIImageView!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var houseLabel: UILabel!
    
    @IBOutlet weak var timerStackView: UIStackView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var playerScore: Int = 0
    var houseScore: Int = 0
    var winner: String = ""
    
    var seconds = 10
    var timer = Timer()
    var isTimerRunning = false
    
    @IBAction func dealButtonPressed(_ sender: UIButton) {
        runTimer()
        
        let playerNum = Int(arc4random_uniform(12))
        let houseNum = Int(arc4random_uniform(12))
        
        playerCard.image = cardArray[playerNum]
        houseCard.image = cardArray[houseNum]
        
        if playerNum > houseNum {
            playerScore += 1
            playerLabel.text = String(playerScore)
        } else if houseNum > playerNum {
            houseScore += 1
            houseLabel.text = String(houseScore)
        }
    }
    
    func runTimer() {
        if isTimerRunning == false {
            
            timerStackView.alpha = 1
            
            isTimerRunning = true
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        }
    }
    
    func updateTimer() {
        if seconds > 0 {
            seconds -= 1
            timerLabel.text = "\(seconds)" + " seconds"
        } else {
            timer.invalidate()
            
            timerStackView.alpha = 0
            
            if playerScore > houseScore {
                winner = "Congratulations, you won!"
            } else if houseScore > playerScore {
                winner = "Aww, too bad... Better luck next time!!"
            } else {
                winner = "What? Who won? Was it a tie? Aargh!"
            }
            
            self.performSegue(withIdentifier: "resultPopUp", sender: nil)
            
            seconds = 10
            playerScore = 0
            houseScore = 0
            playerCard.image = #imageLiteral(resourceName: "back")
            houseCard.image = #imageLiteral(resourceName: "back")
            
            isTimerRunning = false
            
            timerLabel.text = "10 seconds"
            
            playerLabel.text = "0"
            houseLabel.text = "0"
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PopUpViewController, let winner = sender as? String {
            vc.winner = winner
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

