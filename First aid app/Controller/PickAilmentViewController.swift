//
//  PickAilmentViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 25/05/2022.
//

import UIKit

class PickAilmentViewController: UIViewController {
    
    var buttonsStatementArray: [Bool] = [false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeButtonStates(sender: AnyObject) {
        
       guard let ailmentButton = sender as? UIButton else {
            return
        }
        
        func changStatement() {
            if ailmentButton.isSelected == false {
                        ailmentButton.isSelected = true
                        ailmentButton.backgroundColor = UIColor.red
                        ailmentButton.tintColor = UIColor.white
                        buttonsStatementArray[ailmentButton.tag] = true
                    } else {
                        ailmentButton.isSelected = false
                        ailmentButton.backgroundColor = UIColor.white
                        ailmentButton.tintColor = UIColor.black
                        buttonsStatementArray[ailmentButton.tag] = false
                    }
        }
        
        switch ailmentButton.tag {
        case 0:
            changStatement()
        case 1:
            changStatement()
        case 2:
            changStatement()
        case 3:
            changStatement()
        case 4:
            changStatement()
        case 5:
            changStatement()
        case 6:
            changStatement()
        case 7:
            changStatement()
        default:
            return
        }
    }
    
    
    
    @IBAction func moveForwardPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToInstructions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToInstructions" {
            let destinationVC = segue.destination as! DisplayInstructionsViewController
            
            for i in 0...7 {
                destinationVC.buttonsStatementArray[i] = buttonsStatementArray[i]
            }
        }
    }
}
