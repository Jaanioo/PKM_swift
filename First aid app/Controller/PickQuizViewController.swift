//
//  PickQuizViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 02/06/2022.
//

import UIKit

class PickQuizViewController: UIViewController {
    
    @IBOutlet weak var testsResultsButton: UIButton!
    
    var breakingButtonInt = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setPopupButton()
    }
    
    func setPopupButton() {
        
        let optionPortionClosure = {(action: UIAction) in
            print(action.title)
            if action.title == "Ciśnienie krwi" {
                self.performSegue(withIdentifier: "PressureSegue3", sender: self)
            } else if action.title == "Cukier" {
                self.performSegue(withIdentifier: "SugarSegue3", sender: self)
            }
        }
        
        testsResultsButton.menu = UIMenu(children : [
            UIAction(title: "Ciśnienie krwi", state: .off, handler: optionPortionClosure),
            UIAction(title: "Cukier", handler: optionPortionClosure)])
        
        testsResultsButton.showsMenuAsPrimaryAction = true
        testsResultsButton.changesSelectionAsPrimaryAction = true
        testsResultsButton.setTitleColor(UIColor.clear, for: .normal)
        
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is LoggedMainViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
    
    //Moving to the new ViewController by clicking button without segue
    @IBAction func breakingsButtonPressed(_ sender: UIButton) {
        breakingButtonInt = 1
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
    @IBAction func rkoButtonPressed(_ sender: UIButton) {
        breakingButtonInt = 2
        
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    @IBAction func accidentButtonPressed(_ sender: UIButton) {
        breakingButtonInt = 3
       
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    @IBAction func swoonButtonPressed(_ sender: UIButton) {
        breakingButtonInt = 4
        
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    @IBAction func bloodingButtonPressed(_ sender: UIButton) {
        breakingButtonInt = 5
        
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuiz" {
            let destinationVC = segue.destination as! QuizInProgressViewController
            
            destinationVC.quizTypeInt = self.breakingButtonInt
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
