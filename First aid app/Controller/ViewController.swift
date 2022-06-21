//
//  ViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 10/05/2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        
        if user == nil {
            //do nothing
            print("BRAK ZALOGOWANEGO")
        } else {
            performSegue(withIdentifier: "goToLoggedMain", sender: self)
        }
    }


}

