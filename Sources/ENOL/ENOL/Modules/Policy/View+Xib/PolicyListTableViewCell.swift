//
//  PolicyListTableViewCell.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import UIKit

class PolicyListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productNumberLabel: UILabel!
    @IBOutlet weak var productValidLabel: UILabel!
    @IBOutlet weak var productInsureDetailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
