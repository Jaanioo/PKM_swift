//
//  AddPressureViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 17/05/2022.
//

import UIKit
import FirebaseFirestore

class AddPressureViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var systolicPressureTextField: UITextField!
    @IBOutlet weak var diastolicPressureTextField: UITextField!
    @IBOutlet weak var pulseTextField: UITextField!
    
    let systolicPickerData: [Int] = Array(1...300)
    var selectedSystoricPickerData: String? = ""
    var systolicPickerView = UIPickerView()
    
    let diastolicPickerData: [Int] = Array(1...300)
    var selectedDiastolicPickerData: String? = ""
    var diastolicPickerView = UIPickerView()
    
    let pulsePickerData: [Int] = Array(1...300)
    var selectedPulsePickerData: String? = ""
    var pulsePickerView = UIPickerView()
    
    let db = Firestore.firestore()
    
    let dateFormatter = DateFormatter()
    var strDate: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        toolBar.setItems([doneBtn], animated: true)
        
        settingPickerViews()
        settingsDatePicker()
    }
    
    //MARK: - Settings Pickers
    func settingsDatePicker() {
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        strDate = dateFormatter.string(from: datePicker.date)
    }
    
    func settingPickerViews() {
        
        systolicPressureTextField.inputView = systolicPickerView
        //systolicPressureTextField.inputAccessoryView = toolBar
        diastolicPressureTextField.inputView = diastolicPickerView
        pulseTextField.inputView = pulsePickerView
        
        systolicPressureTextField.placeholder = "Wybierz ciśnienie skurczowe"
        diastolicPressureTextField.placeholder = "Wybierz ciśnienie rozkurczowe"
        pulseTextField.placeholder = "Wybierz puls"
        
        systolicPressureTextField.textAlignment = .center
        diastolicPressureTextField.textAlignment = .center
        pulseTextField.textAlignment = .center
        
        self.systolicPickerView.delegate = self
        self.systolicPickerView.dataSource = self
        self.systolicPickerView.selectRow(120, inComponent: 0, animated: true)
        
        self.diastolicPickerView.delegate = self
        self.diastolicPickerView.dataSource = self
        
        self.pulsePickerView.delegate = self
        self.pulsePickerView.dataSource = self
        
        systolicPickerView.tag = 1
        diastolicPickerView.tag = 2
        pulsePickerView.tag = 3
    }
    
    //MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIButton) {

        if let systolicPressure = selectedSystoricPickerData, let diastolicPressure = selectedDiastolicPickerData, let pulse = selectedPulsePickerData,
            let stringDate = strDate {
            db.collection(K.FStore.pressureCollectionName).addDocument(data: [
                K.FStore.systolicPressureField: systolicPressure,
                K.FStore.diastolicPressureField: diastolicPressure,
                K.FStore.pulseField: pulse,
                K.FStore.stringDate: stringDate,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("Wystąpił błąd w zapisie danych w Firestore, \(e)")
                } else {
                    print("Pomyślnie dodano dane.")
                }
            }
        }

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is PressureListViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        
        strDate = dateFormatter.string(from: datePicker.date)
    }
}

//MARK: - Extensions for PickerViews
extension AddPressureViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return systolicPickerData.count
        case 2:
            return diastolicPickerData.count
        case 3:
            return pulsePickerData.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return String(systolicPickerData[row])
        case 2:
            return String(diastolicPickerData[row])
        case 3:
            return String(pulsePickerData[row])
        default:
            return "Nie znaleziono danych"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            systolicPressureTextField.text = String(systolicPickerData[row])
            selectedSystoricPickerData = String(systolicPickerData[row])
            systolicPressureTextField.resignFirstResponder()
        case 2:
            diastolicPressureTextField.text = String(diastolicPickerData[row])
            selectedDiastolicPickerData = String(systolicPickerData[row])
            systolicPressureTextField.resignFirstResponder()
        case 3:
            pulseTextField.text = String(pulsePickerData[row])
            selectedPulsePickerData = String(pulsePickerData[row])
            pulseTextField.resignFirstResponder()
        default:
            return
        }
    }
}
