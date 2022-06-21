//
//  SugarListViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 19/05/2022.
//

import UIKit
import FirebaseFirestore

class SugarListViewController: UIViewController {

    @IBOutlet weak var sugarTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var sugarArray: [Sugar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sugarTableView.dataSource = self
        sugarTableView.register(UINib(nibName: K.sugarCellNibName, bundle: nil), forCellReuseIdentifier: K.sugarCellIdentifier)
        
        loadPressures()
    }
    
    //MARK: - Loading values from firestore
    func loadPressures() {
        
        db.collection(K.FStore.sugarCollectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (QuerySnapshot, error) in
                
                self.sugarArray = []
                
                if let e = error {
                    print("Wystąpił błąd w pobieraniu danych z Firestore. \(e)")
                } else {
                    if let snapshotDocuments = QuerySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if
                                let stringDate = data[K.FStore.stringDate] as? String,
                                let sugarLevel = data[K.FStore.sugarLevelField] as? String {
                                let newSugar = Sugar(stringDate: stringDate, sugarLevel: sugarLevel)
                                self.sugarArray.append(newSugar)
                                
                                DispatchQueue.main.async {
                                    self.sugarTableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
    }
}

//MARK: - tableView settings

extension SugarListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sugarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sugar = sugarArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.sugarCellIdentifier, for: indexPath) as! SugarCell
        
        cell.testDateLabel.text = "Wynik z dnia: \(sugar.stringDate)"
        cell.sugarLevelLabel.text = "Cukier: \(sugar.sugarLevel)"
        
        return cell
    }
}
