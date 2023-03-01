//
//  PolicyListViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import UIKit
import SKActivityIndicatorView

class PolicyListViewController: UIViewController {

    @IBOutlet weak var policyListTableView: UITableView!
    
    var policyData = PolicyViewModel()
    var policyListArray = [PolicyDetails]()
    
    var policyListData = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Initial
    func initialSetup(){
        self.policyListTableView.delegate = self
        self.policyListTableView.dataSource = self
        self.policyListTableView.register(UINib(nibName: "PolicyListTableViewCell", bundle: nil), forCellReuseIdentifier: "PolicyListTableViewCell")
        self.policyListAPI()
    }
    
    //MARK: API Call
    func policyListAPI(){
        SKActivityIndicator.show("Loading...")
        policyData.policyListApiCall{result in
            self.policyListArray = result
            print(self.policyListArray)
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
                self.policyListTableView.reloadData()
            }
        }
    }

}
extension PolicyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.policyListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PolicyListTableViewCell", for: indexPath) as? PolicyListTableViewCell{
            let poliyDetails = policyListArray[indexPath.row]
            cell.productNameLabel.text = poliyDetails.vehicleName
            cell.productNumberLabel.text = poliyDetails.vehicleRegistrationNumber
            cell.productValidLabel.text = poliyDetails.dateOfValidity
            cell.carImageView.loadImage(string: poliyDetails.policyImage)
            cell.productInsureDetailsLabel.text = poliyDetails.productName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetailsViewController") as? PolicyDetailsViewController{
            vc.policyDetail = policyListArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
    
}
