//
//  AccidentScenarioViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 09/02/23.
//

import UIKit
import Foundation
import SKActivityIndicatorView

protocol SelectScenarioVCDelegate {
    func scenarioSelected(scenario:[String:Any])
}

class AccidentScenarioViewController: UIViewController {

    @IBOutlet weak var scenarioTableView: UITableView!
    @IBOutlet weak var headerTitleLabel: UILabel!

    var singleScenarioListArr = [[String:Any]]()
    var twoScenarioListArr = [[String:Any]]()
    
    var firstArrData = [String:Any]()
    var secondArrData = [[String:Any]]()
    
    var isFinalFirstArr = [[String:Any]]()
    var isFinalSecondArr = [[String:Any]]()
    
    var isTwoScenario = Bool()
    var delegate: SelectScenarioVCDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Initial Setup
    func initialSetup(){
        self.scenarioTableView.delegate = self
        self.scenarioTableView.dataSource = self
        self.scenarioTableView.register(UINib(nibName: "TwoScenarioTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoScenarioTableViewCell")
        self.scenarioTableView.register(UINib(nibName: "SingleScenarioTableViewCell", bundle: nil), forCellReuseIdentifier: "SingleScenarioTableViewCell")
        self.getSingleScenarioDetails()
        self.getTwoScenarioDetails()
    }
    
    //MARK: API

    func getSingleScenarioDetails() {
        SKActivityIndicator.show("Loading...")
        AuthManager.getRequest(urlString: Global.WebAPI.SingleScenarioFaultAPI) { (success, msg, data, error) in
            SKActivityIndicator.dismiss()
            if success {
                let JSON = jsonArray(data: data ?? Data.init())
                self.headerTitleLabel.text = JSON["display_text"] as? String ?? ""
                if let dataArr = JSON["vehicleNotInvolvedScenarios"] as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.singleScenarioListArr = dataArr
                        self.scenarioTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getTwoScenarioDetails() {
        AuthManager.getRequest(urlString: Global.WebAPI.TwoScenarioFaultAPI) { (success, msg, data, error) in
            if success {
                let JSON = jsonArray(data: data ?? Data.init())
                self.headerTitleLabel.text = JSON["display_text"] as? String ?? ""
                if let dataArr = JSON["vehicleInvolvedScenarios"] as? [[String: Any]] {
//                    for scenarios in 0..<self.twoScenarioListArr.count{
//                        let twoScenarioFirst = self.twoScenarioListArr[scenarios]["first"] as? [String:Any]
//                        let twoScenarioSecond = self.twoScenarioListArr[scenarios]["second"] as? [String:Any]
//                        if ((twoScenarioFirst) != nil) {
//                            self.isFinalFirstArr.append(twoScenarioFirst ?? [String:Any]())
//                            print(self.isFinalFirstArr)
//                        }
//                        if ((twoScenarioSecond) != nil){
//                            self.isFinalSecondArr.append(twoScenarioSecond ?? [String:Any]())
//                            print(self.isFinalSecondArr)
//                        }
//                    }
                    DispatchQueue.main.async {
                        self.twoScenarioListArr = dataArr
                        self.scenarioTableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: Button
    @IBAction func backButton_Tapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightButtonPressed(_ sender: UIButton) {
        let cellData = self.twoScenarioListArr[sender.tag]
        let secondData = cellData["second"] as? [String:Any] ?? [String:Any]()
        showAlerConfirmation(scenario:secondData)
    }
    @objc func leftButtonPressed(_ sender: UIButton) {
        let cellData = self.twoScenarioListArr[sender.tag]
        let firstData = cellData["first"] as? [String:Any] ?? [String:Any]()
        showAlerConfirmation(scenario:firstData)
    }
    
    @objc func fullButtonPressed(_ sender: UIButton) {
        let cellData = self.singleScenarioListArr[sender.tag]
        showAlerConfirmation(scenario:cellData)
    }

}
extension AccidentScenarioViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTwoScenario == true {
            return self.twoScenarioListArr.count
        } else {
            return self.singleScenarioListArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTwoScenario == true {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TwoScenarioTableViewCell", for: indexPath) as? TwoScenarioTableViewCell {
                let cellData = self.twoScenarioListArr[indexPath.row]
                let firstData = cellData["first"] as? [String:Any]
                let secondData = cellData["second"] as? [String:Any]
                cell.titleLbl.text = firstData?["title"] as? String ?? ""
                cell.leftScenarioDescLbl.text = firstData?["description"] as? String ?? ""
                cell.leftScenarioDetailsLbl.text = firstData?["faultTitle"] as? String ?? ""
                cell.leftImageView.loadImage(string: firstData?["imageUrl"] as? String ?? "")
                cell.rightScenarioDescLbl.text = secondData?["description"] as? String ?? ""
                cell.rightScenarioDetailsLbl.text = secondData?["faultTitle"] as? String ?? ""
                cell.rightImageView.loadImage(string: secondData?["imageUrl"] as? String ?? "")
                cell.rightScenarioBtn.tag = indexPath.row
                cell.rightScenarioBtn.addTarget(self, action: #selector(rightButtonPressed(_:)), for: .touchUpInside)
                cell.leftScenarioBtn.tag = indexPath.row
                cell.leftScenarioBtn.addTarget(self, action: #selector(leftButtonPressed(_:)), for: .touchUpInside)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SingleScenarioTableViewCell", for: indexPath) as? SingleScenarioTableViewCell {
                let cellData = self.singleScenarioListArr[indexPath.row]
                cell.descLabel.text = cellData["description"] as? String ?? ""
                cell.titlLabl.text = cellData["title"] as? String ?? ""
                cell.imgView.loadImage(string: cellData["imageUrl"] as? String ?? "")
                cell.fullButton.tag = indexPath.row
                cell.fullButton.addTarget(self, action: #selector(fullButtonPressed(_:)), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isTwoScenario == true {
            return 255.0
        } else {
            return 180.0
        }
        
    }
    
    func showAlerConfirmation(scenario: [String:Any]){
        let showAlert = UIAlertController(title: scenario["title"] as? String ?? "", message: scenario["description"] as? String ?? "", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 90, width: 250, height: 200))
        imageView.loadImage(string: scenario["imageUrl"] as? String ?? "")
        showAlert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: showAlert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
        let width = NSLayoutConstraint(item: showAlert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        showAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.delegate?.scenarioSelected(scenario:scenario)
            self.navigationController?.popViewController(animated: true)
        }))
        showAlert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(showAlert, animated: true, completion: nil)
    }
    
}
