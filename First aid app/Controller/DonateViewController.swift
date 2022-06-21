//
//  DonateViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 09/06/2022.
//

import UIKit

class DonateViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Jeśli chcesz wspierać rozwój aplikacji możesz dokonać wpłaty na konto podane poniżej: \n\n123456789005874"
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is LoggedMainViewController){
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
