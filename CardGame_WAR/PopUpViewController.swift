//
//  PopUpViewController.swift
//  CardGame_WAR
//
//  Created by Tobias on 2017-09-05.
//  Copyright © 2017 Tobias Rödebäck. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    // A reference outlet to the label presents the winner
    @IBOutlet weak var resultLabel: UILabel!
    
    // A reference outlet to the view handling the blur effect
    @IBOutlet weak var blurView: UIView!
    
    // The variable that is used to present the winner - the current value is the default message
    var result = "What? Who won? Was it a tie? Aargh!"

    // Method comparable to android onCreate - runs as soon as the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling the blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        
        // Applying the blur effect to a view
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Setting the size of the view
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Adding the newly created blur effect view as a subview to my custom blurView
        blurView.addSubview(blurEffectView)
        
        // Sets the label with the variable winner
        resultLabel.text = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function for restart button
    @IBAction func restartGame(_ sender: UIButton) {
        
        // Simply dismisses popover and returns to the former View
        dismiss(animated: true, completion: nil)
        
    }

}
