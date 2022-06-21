//
//  AddSugarViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 19/05/2022.
//

import UIKit
import FirebaseFirestore

class AddSugarViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sugarLevelTextField: UITextField!
    
    let sugarPickerData: [Int] = Array(1...300)
    var selectedSugarPickerData: String? = ""
    var sugarPickerView = UIPickerView()
    
    let dateFormatter = DateFormatter()
    var strDate: String? = ""
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsDatePicker()
        settingPickerViews()
    }
    
    //MARK: - Settings Pickers
    
    func settingsDatePicker() {
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        strDate = dateFormatter.string(from: datePicker.date)
    }
    
    func settingPickerViews() {
        
        sugarLevelTextField.inputView = sugarPickerView
        sugarLevelTextField.placeholder = "Wybierz stężenie cukru"
        sugarLevelTextField.textAlignment = .center
        
        self.sugarPickerView.delegate = self
        self.sugarPickerView.dataSource = self
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        if let stringDate = strDate, let sugarLevel = selectedSugarPickerData {
            db.collection(K.FStore.sugarCollectionName).addDocument(data: [
                K.FStore.stringDate: stringDate,
                K.FStore.sugarLevelField: sugarLevel,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("Wystąpił błąd w zapisie danych fo firestore: \(e)")
                } else {
                    print("Pomylnie dodano dane.")
                }
                
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is SugarListViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        strDate = dateFormatter.string(from: datePicker.date)
    }
}

//MARK: - Extensions

extension AddSugarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sugarPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(sugarPickerData[row])
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sugarLevelTextField.text = String(sugarPickerData[row])
        selectedSugarPickerData = String(sugarPickerData[row])
        sugarLevelTextField.resignFirstResponder()
    }
}

