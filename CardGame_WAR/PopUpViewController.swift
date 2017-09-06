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
    
    var winner = "What? Who won? Was it a tie? Aargh!"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerLabel.text = winner

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
