//
//  PresureCell.swift
//  First aid app
//
//  Created by Jan Paleń on 16/05/2022.
//

import UIKit

class PressureCell: UITableViewCell {

    @IBOutlet weak var testDateLabel: UILabel!
    @IBOutlet weak var systolicPressureLabel: UILabel!
    @IBOutlet weak var diastolicPressureLabel: UILabel!
    @IBOutlet weak var pulseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
