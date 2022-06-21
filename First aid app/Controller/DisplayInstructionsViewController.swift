//
//  DisplayInstructionsViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 25/05/2022.
//

import UIKit
import FirebaseAuth

class DisplayInstructionsViewController: UIViewController {
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var instructionsImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var buttonsStatementArray: [Bool] = [false, false, false, false, false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Przycisk 1: \(buttonsStatementArray[0])")
        print("Przycisk 2: \(buttonsStatementArray[1])")
        print("Przycisk 3: \(buttonsStatementArray[2])")
        print("Przycisk 4: \(buttonsStatementArray[3])")
        print("Przycisk 5: \(buttonsStatementArray[4])")
        print("Przycisk 6: \(buttonsStatementArray[5])")
        print("Przycisk 7: \(buttonsStatementArray[6])")
        print("Przycisk 8: \(buttonsStatementArray[7])")
        changingInstructions()
    }
    
    //MARK: - Changing instructions in time
    func changingInstructions() {
        
        for i in (0...buttonsStatementArray.count) {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 4 * Double(i)) {
                if i >= self.buttonsStatementArray.startIndex && i < self.buttonsStatementArray.endIndex {
                    
                    if self.buttonsStatementArray[i] == true && i == 0 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Odchyl głowę poszkodowanego, wpuść powietrze do momentu uniesienia klatki piersiowej. \n Powtórz dwukrotnie."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = false
                        self.instructionsImageView.image = UIImage(named: "ilustracjaoddech")
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 1 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Rytmicznie uciskaj mostek dwoma rękoma ułożonymi dłoń na głębokość 5 cm w linii środkowej klatki peirsiowej."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = false
                        self.instructionsImageView.image = UIImage(named: "tetnoilustracja")
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 2 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Jeśli uszkodzeniu uległ staw, zastosuj unieruchomienie tego stawu oraz dwóch sąsiednich kości. \n Jeśli uszkodzeniu uległa kość, zastosuj unieruchomienie dwóch sąsiednich stawów."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = false
                        self.instructionsImageView.image = UIImage(named: "nogailustracja")
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 3 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Jeśli uszkodzeniu uległ staw, zastosuj unieruchomienie tego stawu oraz dwóch sąsiednich kości. \n Jeśli uszkodzeniu uległa kość, zastosuj unieruchomienie dwóch sąsiednich stawów."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = false
                        self.instructionsImageView.image = UIImage(named: "rekailustracja")
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 4 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Jeśli złamaniu towarzyszy krwotok, należy ułożyć poszkodowanego w pozycji siedzącej, a następnie przyłożyć zimny okład oraz zatamować krwawienie gazą lub chusteczką."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = true
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 5 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Należy podać choremu mocną herbatę liściastą, która wiąże niektóre substancje wywołujące wymioty oraz węgiel aktywny."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = true
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 6 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Należy uspokoić poszkodowanego, \n położyć go w pozycji półsiedzącej, poluzować ciasną odzież oraz zapewnić dostęp do świeżego powietrza."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = true
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    } else if self.buttonsStatementArray[i] == true && i == 7 {
                        print("WOŁANIE: \(i)")
                        self.instructionsLabel.text = "Należy położyć poszkodowanego w pozycji bocznej- bezpiecznej. \n Sprawdźić czy wyczuwalny jest puls i oddech. Jeśli nie wyczuwasz przystąp do RKO. \n Gdy wyczuwasz oddech i puls próbuj delikatnie ocucić poszkodowanego."
                        self.logoImageView.isHidden = true
                        self.infoLabel.isHidden = true
                        self.instructionsImageView.isHidden = true
                        self.backButton.isHidden = true
                        self.finishButton.isHidden = false
                    }
                }
            }
        }
    }
    
    //MARK: - buttons settings
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Moving from popup VC to another presenting with NavigationController
    @IBAction func finishButtonPressed(_ sender: UIButton) {
       
        let presentingController = self.presentingViewController
        
        if Auth.auth().currentUser == nil {
            self.dismiss(animated: true) {
                if let navigationController = presentingController as? UINavigationController,
                    let notLoggedMainViewController = navigationController.viewControllers.first(
                        where: { viewController in
                            viewController is ViewController
                        }
                    ) {
                    navigationController.popToViewController(notLoggedMainViewController, animated: true)
                }
            }
        } else {
            
            self.dismiss(animated: true) {
                if let navigationController = presentingController as? UINavigationController,
                   let notLoggedMainViewController = navigationController.viewControllers.first(
                       where: { viewController in
                           viewController is LoggedMainViewController
                       }
                   ) {
                   navigationController.popToViewController(notLoggedMainViewController, animated: true)
                }
            }
        }
    }
}
    

