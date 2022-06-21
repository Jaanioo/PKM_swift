//
//  SugarCell.swift
//  First aid app
//
//  Created by Jan Paleń on 19/05/2022.
//

import UIKit

class SugarCell: UITableViewCell {

    @IBOutlet weak var testDateLabel: UILabel!
    @IBOutlet weak var sugarLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
