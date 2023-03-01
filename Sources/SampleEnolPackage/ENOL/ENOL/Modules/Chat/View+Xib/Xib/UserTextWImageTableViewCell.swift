//
//  UserTextWImageTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import UIKit

class UserTextWImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scenarioImg: UIImageView!
    @IBOutlet weak var userTimeLbl: UILabel!
    
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var botTimeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
