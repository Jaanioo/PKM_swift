//
//  MedicinesViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 13/05/2022.
//

import UIKit
import FirebaseFirestore

class MedicinesViewController: UIViewController {
    
    @IBOutlet weak var medsTableView: UITableView!
    @IBOutlet weak var medNameTextField: UITextField!
    @IBOutlet weak var portionPopupButton: UIButton!
    @IBOutlet weak var frequencyPopupButton: UIButton!
    
    let db = Firestore.firestore()
    
    var medicines: [Medicines] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        medsTableView.dataSource = self
        
        medsTableView.register(UINib(nibName: K.medsCellNibName, bundle: nil), forCellReuseIdentifier: K.medsCellIdentifier)
        
        setPopupButtons()
        loadMeds()
    }
    
    //MARK: - Loading list of medicaments
    func loadMeds() {
        
        db.collection(K.FStore.medsCollectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (QuerySnapshot, error) in
                
                self.medicines = []
                
                if let e = error {
                    print("Wystąpił błąd w pobieraniu danych z Firestore. \(e)")
                } else {
                    if let snapshotDocuments = QuerySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let medName = data[K.FStore.nameField] as? String,
                                let medFrequency = data[K.FStore.frequencyField] as? String,
                                let medPortions = data[K.FStore.portionsField] as? String {
                                let newMedicine = Medicines(medName: medName, medFrequency: medFrequency, medPortions: medPortions)
                                self.medicines.append(newMedicine)
                                
                                DispatchQueue.main.async {
                                    self.medsTableView.reloadData()
                                    //let indexPath = IndexPath(row: self.medicines.count, section: 0)
                                    //self.medsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    //MARK: - setting the popup buttons
    func setPopupButtons() {
        
        let optionPortionClosure = {(action: UIAction) in
            print(action.title)
        }
        
        let optionFrequencyClosure = {(action: UIAction) in
            print(action.title)
        }
        
        portionPopupButton.menu = UIMenu(children : [
            UIAction(title: "1 tabletka", state: .on, handler: optionPortionClosure),
            UIAction(title: "2 tabletki", handler: optionPortionClosure),
        UIAction(title: "3 tabletki", handler: optionPortionClosure),
        UIAction(title: "5 ml", handler: optionPortionClosure),
        UIAction(title: "10 ml", handler: optionPortionClosure),
        UIAction(title: "15 ml", handler: optionPortionClosure),
        UIAction(title: "20 ml", handler: optionPortionClosure)])
        
        frequencyPopupButton.menu = UIMenu(children: [
            UIAction(title: "Raz dziennie", state: .on, handler: optionFrequencyClosure),
            UIAction(title: "Dwa razy dziennie", handler: optionFrequencyClosure),
            UIAction(title: "Trzy razy dziennie", handler: optionFrequencyClosure),
            UIAction(title: "Raz na dwa dni", handler: optionFrequencyClosure),
            UIAction(title: "Raz na trzy dni", handler: optionFrequencyClosure),
            UIAction(title: "Raz w tygodniu", handler: optionFrequencyClosure)])
        
        portionPopupButton.showsMenuAsPrimaryAction = true
        portionPopupButton.changesSelectionAsPrimaryAction = true
        frequencyPopupButton.showsMenuAsPrimaryAction = true
        frequencyPopupButton.changesSelectionAsPrimaryAction = true
    }
    
    //MARK: - sending values to firestore
    @IBAction func addPressed(_ sender: UIButton) {
        
        if medNameTextField.text != "" {
            
            if let medName = medNameTextField.text, let medFrequency = frequencyPopupButton.currentTitle, let medPortions = portionPopupButton.currentTitle {
                db.collection(K.FStore.medsCollectionName).addDocument(data: [
                    K.FStore.nameField: medName,
                    K.FStore.frequencyField: medFrequency,
                    K.FStore.portionsField: medPortions,
                    K.FStore.dateField: Date().timeIntervalSince1970
                ]) { error in
                    if let e = error {
                        print("Wystąpił błąd w zapisie danych w Firestore, \(e)")
                    } else {
                        print("Pomyślnie dodano dane.")
                    
                        DispatchQueue.main.async {
                            self.medNameTextField.text = ""
                        }
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Puste pole", message: "Nie wprowadzono nazwy leku!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Zamknij", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - tableView settings
extension MedicinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let medicine = medicines[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.medsCellIdentifier, for: indexPath) as! MedicinesCell
        
        cell.medicationNameLabel.text = medicine.medName
        cell.medsFrequencyLabel.text = "Częstotliwość: \(medicine.medFrequency)"
        cell.medsPortionsLabel.text = "Dawkowanie: \(medicine.medPortions)"
        
        return cell
    }
    
}
