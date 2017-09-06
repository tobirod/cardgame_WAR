//
//  PopUpViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-05.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    // A reference outlet to the label that shows who won the game
    @IBOutlet weak var winnerLabel: UILabel!
    
    // The variable that is used to present the winner - the current value is the default message
    var winner = "What? Who won? Was it a tie? Aargh!"

    // Method comparable to android onCreate - runs as soon as the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the label with the variable winner
        winnerLabel.text = winner
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function for restart button
    @IBAction func restartGame(_ sender: UIButton) {
        
        // Simply dismisses popover
        dismiss(animated: true, completion: nil)
        
    }

}
