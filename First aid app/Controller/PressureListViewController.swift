//
//  PresureListViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 16/05/2022.
//

import UIKit
import FirebaseFirestore

class PressureListViewController: UIViewController {

    @IBOutlet weak var pressureTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var pressures: [Pressure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pressureTableView.dataSource = self
        
        pressureTableView.register(UINib(nibName: K.pressureCellNibName, bundle: nil), forCellReuseIdentifier: K.pressureCellIdentifier)
        
        loadPressures()
        
    }

    @IBAction func addPressureResultClicked(_ sender: UIButton) {
    }
    
    //MARK: - Loading values from Firestore
    
    func loadPressures() {
        
        db.collection(K.FStore.pressureCollectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (QuerySnapshot, error) in
                
                self.pressures = []
                
                if let e = error {
                    print("Wystąpił błąd w pobieraniu danych z Firestore. \(e)")
                } else {
                    if let snapshotDocuments = QuerySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if
                                let stringDate = data[K.FStore.stringDate] as? String,
                                let systolicPressure = data[K.FStore.systolicPressureField] as? String,
                                let diastolicPressure = data[K.FStore.diastolicPressureField] as? String,
                                let pulse = data[K.FStore.pulseField] as? String {
                                let newPressure = Pressure(stringDate: stringDate, systolicPressure: systolicPressure, diastolicPressure: diastolicPressure, pulse: pulse)
                                self.pressures.append(newPressure)
                                
                                DispatchQueue.main.async {
                                    self.pressureTableView.reloadData()
                                    //let indexPath = IndexPath(row: self.pressures.count, section: 0)
                                    //self.pressureTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
}

//MARK: - tableView settings

extension PressureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pressures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pressure = pressures[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.pressureCellIdentifier, for: indexPath) as! PressureCell
        
        cell.testDateLabel.text = "Wynik z dnia: \(pressure.stringDate)"
        cell.systolicPressureLabel.text = "Skurczowe: \(pressure.systolicPressure)"
        cell.diastolicPressureLabel.text = "Rozkurczowe: \(pressure.diastolicPressure)"
        cell.pulseLabel.text = "Puls: \(pressure.pulse)"
        
        return cell
    }
}
