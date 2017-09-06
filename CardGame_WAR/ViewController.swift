//
//  ViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-01.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Array with all the cards of the deck
    let cardArray = [#imageLiteral(resourceName: "ace"), #imageLiteral(resourceName: "card2"), #imageLiteral(resourceName: "card3"), #imageLiteral(resourceName: "card4"), #imageLiteral(resourceName: "card5"), #imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card7"), #imageLiteral(resourceName: "card8"), #imageLiteral(resourceName: "card9"), #imageLiteral(resourceName: "card10"), #imageLiteral(resourceName: "jack"), #imageLiteral(resourceName: "queen"), #imageLiteral(resourceName: "king")]
    
    // A reference outlet to the image view containing the player card
    @IBOutlet weak var playerCard: UIImageView!
    
    // A reference outlet to the image view containing the house card
    @IBOutlet weak var houseCard: UIImageView!
    
    // A reference outlet to the label that displays the player score
    @IBOutlet weak var playerLabel: UILabel!
    
    // A reference outlet to the label that displays the house score
    @IBOutlet weak var houseLabel: UILabel!
    
    // A reference outlet to the vertical stackview that holds everything related to the timer
    @IBOutlet weak var timerStackView: UIStackView!
    
    // A reference outlet to the label that shows the actual timer
    @IBOutlet weak var timerLabel: UILabel!
    
    // A variable containing the player score, initialized as 0 (No cheaters allowed)
    var playerScore: Int = 0
    
    // A variable containing the house score, initialized as 0 (No cheaters allowed)
    var houseScore: Int = 0
    
    // An empty variable meant to be updated after game is ended
    var result: String = ""
    
    // Variable determining how many seconds the timer will run
    var seconds = 10
    
    // Creating a new instance of timer
    var timer = Timer()
    
    // Boolean telling if the timer is running or not
    var isTimerRunning = false
    
    // Function activated when pressing the deal button
    @IBAction func dealButtonPressed(_ sender: UIButton) {
        
        // Running the function for starting the timer
        runTimer()
        
        // Randomizing a number between 0 and 12, which symbolizes the value of the player card
        let playerNum = Int(arc4random_uniform(12))
        
        // Randomizing a number between 0 and 12, which symbolizes the value of the house card
        let houseNum = Int(arc4random_uniform(12))
        
        // Setting the imageview with the card equal to playerNum (which was just randomized) from the array
        playerCard.image = cardArray[playerNum]
        
        // Setting the imageview with the card equal to houseNum (which was just randomized) from the array
        houseCard.image = cardArray[houseNum]
        
        // Determining the current rounds winner by score
        // If player has the highest card, add one to playerScore, and display the new score
        if playerNum > houseNum {
            playerScore += 1
            playerLabel.text = String(playerScore)
            
        // If house has the highest card, add one to houseScore, and display the new score
        } else if houseNum > playerNum {
            houseScore += 1
            houseLabel.text = String(houseScore)
        }
    }
    
    // Function for running the timer
    func runTimer() {
        
        // Runs if timer isn't running
        if isTimerRunning == false {
            
            // Sets the alpha of the stackview to 1, making it visible
            timerStackView.alpha = 1
            
            // Timer is running
            isTimerRunning = true
            
            // The actual timer: timeInterval specifies time between ticks, selector specifies the function that is to be activated every tick
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        }
    }
    
    // Runs every tick of the timer
    func updateTimer() {
        
        // If there's more than 0 seconds left on the timer...
        if seconds > 0 {
            
            // Detract 1 from variable seconds
            seconds -= 1
            
            // Update timerLabel with new value
            timerLabel.text = "\(seconds)" + " seconds"
            
            // If there's 0 or less seconds left on the timer...
        } else {
            
            // Stop timer
            timer.invalidate()
            
            // Sets alpha to 0, effectively hiding everything related to the timer again
            timerStackView.alpha = 0
            
            // Determining who won
            // If the player has a greater score than house...
            if playerScore > houseScore {
                
                // ... set winner
                result = "Congratulations, you won!"
                
            // If the house has a greater score than player...
            } else if houseScore > playerScore {
                
                // ... set winner
                result = "Aww, too bad... Better luck next time!!"
                
            // If the player and the house are tied, or something else has happened
            } else {
                
                // ... set default text
                result = "What? Who won? Was it a tie? Aargh!"
            }
            
            // Activating the segue shows the popup. Note that the variable winner is added, so it will be shown in the popup
            self.performSegue(withIdentifier: "resultPopUp", sender: result)
            
            // Reset all the variables to the original values
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
    
    // A function in the superclass which lets us prepare for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If the segue destination is the class PopUpViewController (my custom popup) we set it's winner property to the sender, if the sender is of the type String
        if let vc = segue.destination as? PopUpViewController, let result = sender as? String {
            vc.result = result
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

