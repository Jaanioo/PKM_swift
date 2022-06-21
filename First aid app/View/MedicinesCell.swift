//
//  MedicinesCell.swift
//  First aid app
//
//  Created by Jan Paleń on 13/05/2022.
//

import UIKit

class MedicinesCell: UITableViewCell {

    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var medsPortionsLabel: UILabel!
    @IBOutlet weak var medsFrequencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
