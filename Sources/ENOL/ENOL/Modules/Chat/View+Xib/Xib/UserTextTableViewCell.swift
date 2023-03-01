//
//  UserTextTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import UIKit

class UserTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
