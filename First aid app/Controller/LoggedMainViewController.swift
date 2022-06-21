//
//  LoggedMainViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 11/05/2022.
//

import UIKit
import FirebaseAuth

class LoggedMainViewController: UIViewController {

    @IBOutlet weak var testsResultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPopupButton()
    }
    
    func setPopupButton() {
        
        let optionPortionClosure = {(action: UIAction) in
            print(action.title)
            if action.title == "Ciśnienie krwi" {
                self.performSegue(withIdentifier: "PressureSegue", sender: self)
            } else if action.title == "Cukier" {
                self.performSegue(withIdentifier: "SugarSegue", sender: self)
            }
        }
        
        testsResultsButton.menu = UIMenu(children : [
            UIAction(title: "Ciśnienie krwi", state: .off, handler: optionPortionClosure),
            UIAction(title: "Cukier", handler: optionPortionClosure)])
        
        testsResultsButton.showsMenuAsPrimaryAction = true
        testsResultsButton.changesSelectionAsPrimaryAction = true
        testsResultsButton.setTitleColor(UIColor.clear, for: .normal)
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
        try! Auth.auth().signOut()

        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is ViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
}

