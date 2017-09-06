//
//  PopUpViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-05.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!

    var gameResult: GameResult!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let gameResult = gameResult else { return // Game result was not passed! 
        }
        
        if gameResult.wasTied {
            self.winnerLabel.text = "Aww, too bad! The game was tied, play again!"
        
        } else {
            self.winnerLabel.text = self.gameResult.winner + " beat " + self.gameResult.loser + " with \(self.gameResult.winnerPoints) points to \(self.gameResult.loserPoints)"
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
