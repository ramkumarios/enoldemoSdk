//
//  PolicyDetailsViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import UIKit

class PolicyDetailsViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productNumberLabel: UILabel!
    @IBOutlet weak var productValidLabel: UILabel!
    
    @IBOutlet var productDetailsLabel: [UILabel]!
    
    var policyDetail:PolicyDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: intial
    func initialSetup(){
        UserDefaults.standard.set(self.policyDetail?.sender_id, forKey: Global.UDKeys.SenderId)
        UserDefaults.standard.set(self.policyDetail?.policy_id, forKey: Global.UDKeys.PolicyId)
        UserDefaults.standard.set(self.policyDetail?.vehicleRegistrationNumber, forKey: Global.UDKeys.VehicleNumber)
        self.productImageView.loadImage(string: self.policyDetail?.policyImage ?? "")
        self.productNameLabel.text = self.policyDetail?.vehicleName
        self.productNumberLabel.text = self.policyDetail?.vehicleRegistrationNumber
        self.productValidLabel.text = self.policyDetail?.dateOfValidity
        self.productDetailsLabel[0].text = self.policyDetail?.productName
        self.productDetailsLabel[1].text = self.policyDetail?.vehicleRegistrationNumber
        self.productDetailsLabel[2].text = self.policyDetail?.policy_premium
        self.productDetailsLabel[3].text = self.policyDetail?.vehicleValue
        self.productDetailsLabel[4].text = self.policyDetail?.policyStartDate
        self.productDetailsLabel[5].text = self.policyDetail?.policyEndDate
        self.productDetailsLabel[6].text = self.policyDetail?.policyNumber
        self.productDetailsLabel[7].text = self.policyDetail?.noClaimBonus
        print(policyDetail)
    }
    
    //MARK: Button action
    @IBAction func claimButton_Tapped(_ sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatAssistViewController") as? ChatAssistViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backButton_Tapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
