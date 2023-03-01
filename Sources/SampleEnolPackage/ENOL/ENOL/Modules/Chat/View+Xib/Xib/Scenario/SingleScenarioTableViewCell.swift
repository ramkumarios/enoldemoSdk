//
//  SingleScenarioTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 10/02/23.
//

import UIKit

class SingleScenarioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titlLabl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var fullButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
