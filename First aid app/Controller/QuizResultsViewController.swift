//
//  QuizResultsViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 03/06/2022.
//

import UIKit

class QuizResultsViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var finishingText: UILabel!
    
    var points: Int = 0
    var numberOfQuestions: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let percentageOfPoints = Float(points / numberOfQuestions)

        pointsLabel.text = "\(points) / \(numberOfQuestions)"
        
        if percentageOfPoints == 1 {
            finishingText.text = "Wspaniale! \nZdobyłeś maksymalną liczbę punktów. \nSprawdź się w innym quizie!"
        } else if percentageOfPoints <= 1 && percentageOfPoints >= 0.7 {
            finishingText.text = "Całkiem niezły wynik! \nZostały drobne szczególy do nauczenia!"
        } else if percentageOfPoints < 0.7 && percentageOfPoints >= 0.4 {
            finishingText.text = "Wynik akceptowalny. \nPowinieneś więcej się nauczyć."
        } else if percentageOfPoints < 0.4 && percentageOfPoints >= 0 {
            finishingText.text = "Masz dużo do nadrobienia!"
        } else {
            finishingText.text = "Nie nauczyłeś się niczego..."
        }
       
    }
    
    @IBAction func finishQuizButton(_ sender: Any) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is PickQuizViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
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
