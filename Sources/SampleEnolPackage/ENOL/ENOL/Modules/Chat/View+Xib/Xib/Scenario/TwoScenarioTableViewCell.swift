//
//  TwoScenarioTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 10/02/23.
//

import UIKit

class TwoScenarioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var leftScenarioDescLbl: UILabel!
    @IBOutlet weak var leftScenarioDetailsLbl: UILabel!
    @IBOutlet weak var rightScenarioDescLbl: UILabel!
    @IBOutlet weak var rightScenarioDetailsLbl: UILabel!
    
    @IBOutlet weak var leftScenarioBtn: UIButton!
    @IBOutlet weak var rightScenarioBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
