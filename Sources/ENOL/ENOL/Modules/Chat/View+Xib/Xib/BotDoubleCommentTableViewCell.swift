//
//  BotDoubleCommentTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import UIKit

class BotDoubleCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var claimButton: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
