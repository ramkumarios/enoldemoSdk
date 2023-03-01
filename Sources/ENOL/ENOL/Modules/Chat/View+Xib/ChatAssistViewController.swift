//
//  ChatAssistViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import UIKit
import SKActivityIndicatorView

class ChatAssistViewController: UIViewController, SelectScenarioVCDelegate, currentLocation {

    @IBOutlet weak var chatAssistTableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var undoButton: UIButton!
    
    @IBOutlet weak var webMessageLbl: UILabel!
    @IBOutlet weak var webURLView: UIView!
    @IBOutlet weak var webURLViewHeightCons: NSLayoutConstraint!
    
    var userId = String()
    var senderId = String()
    var token = String()
    var policyId = String()
    var vehicleNo = String()
    
    var chatDataVM = ChatViewModel()
    var isForConfirm = 0
    var isInvolved = false
    var isNoCurtosyCar = true
    
    var isInvolvedToPass = true
    
    var delegates : SelectScenarioVCDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.delegates = self
    }
    
    func scenarioSelected(scenario: [String : Any]) {
        print(scenario)
        recoverEmpty(Scene: scenario)
        if scenario["isAtFault"] as? Int ?? 0 == 0 {
            noFaultScenarioAPI()
        } else {
            faultScenarioAPI(scenario: scenario)
        }
    }
    
    func recoverEmpty(Scene : [String : Any]) {
        print(Scene)
        print("I'm for contains any empty")
    }
    
    func currentLocWithLatLong(lat: Double, Long: Double) {
        print("\(lat) \(Long)")
        let latitude = String(lat)
        let longitude = String(Long)
        accidentLocationAPI(lat: latitude, long: longitude)
    }
    
    
    //MARK: Initial
    func initialSetup(){
        self.undoButton.isHidden = true
        self.messageView.isHidden = true
        self.messageViewHeightCons.constant = 0 // 50
        self.webURLView.isHidden = true
        self.webURLViewHeightCons.constant = 0
        self.userId = UserDefaults.standard.string(forKey: Global.UDKeys.UserId) ?? ""
        self.senderId = UserDefaults.standard.string(forKey: Global.UDKeys.SenderId) ?? ""
        self.token = UserDefaults.standard.string(forKey: Global.UDKeys.Token) ?? ""
        self.policyId = UserDefaults.standard.string(forKey: Global.UDKeys.PolicyId) ?? ""
        self.vehicleNo = UserDefaults.standard.string(forKey: Global.UDKeys.VehicleNumber) ?? ""
        self.initialMessageAPI()
        self.chatAssistTableView.delegate = self
        self.chatAssistTableView.dataSource = self
        self.chatAssistTableView.register(UINib(nibName: "UserTextTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTextTableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserTextWImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTextWImageTableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "BotDoubleCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "BotDoubleCommentTableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserTextDoubleCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTextDoubleCommentTableViewCell")
        
        self.chatAssistTableView.register(UINib(nibName: "UserText4TableViewCell", bundle: nil), forCellReuseIdentifier: "UserText4TableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserText6TableViewCell", bundle: nil), forCellReuseIdentifier: "UserText6TableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserText8TableViewCell", bundle: nil), forCellReuseIdentifier: "UserText8TableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserText11TableViewCell", bundle: nil), forCellReuseIdentifier: "UserText11TableViewCell")
        
        self.chatAssistTableView.register(UINib(nibName: "UserTextDoubleActionTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTextDoubleActionTableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserTextDoubleAction9TableViewCell", bundle: nil), forCellReuseIdentifier: "UserTextDoubleAction9TableViewCell")
        self.chatAssistTableView.register(UINib(nibName: "UserDoubleAction10TableViewCell", bundle: nil), forCellReuseIdentifier: "UserDoubleAction10TableViewCell")
    }
    
    
    func scrollToBottom(){
        
        let indexPath = IndexPath(row: self.chatDataVM.chatsData.chatHistory.count-1, section: 0)
        self.chatAssistTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    //MARK: Api
    func initialMessageAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"hi", "device":"mobile", "user_id":userId, "sender":senderId, "token":token,"step_id":1] as [String : Any]
        chatDataVM.chatDataApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.async {
                let cellData = self?.chatDataVM.chatsData.chatHistory
                if cellData != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                        if self?.isInvolved == true{
                            self?.messageView.isHidden = false
                            self?.messageViewHeightCons.constant = 50
                        } else {
                            self?.messageView.isHidden = true
                            self?.messageViewHeightCons.constant = 0
                        }
                        SKActivityIndicator.dismiss()
                        self?.view.isUserInteractionEnabled = true
                        self?.chatAssistTableView.reloadData()
                        self?.scrollToBottom()
                    }
                }
            }
        }
    }

    func initiateClaimAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"claim initialize", "vehicle_no":vehicleNo, "policy_id":policyId, "sender":senderId, "token":token] as [String : Any]
        let params = ["message":"confirm vehicle no", "token":token, "sender":senderId]
        if isForConfirm == 1{
            chatDataVM.chatClaimApiCall(parameter: param){[weak self] breaches in
                SKActivityIndicator.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    self?.initialMessageAPI()
                }
            }
        } else if isForConfirm == 2 {
            chatDataVM.confirmVNumberApiCall(parameter: params){[weak self] breaches in
                SKActivityIndicator.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    self?.initialMessageAPI()
                }
            }
        }
    }
    
    func vehicleInvolvedAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"other vehicle involved","token":token,"sender":senderId]
        chatDataVM.otherVehicleInvolvedApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.isInvolved = true
                self?.initialMessageAPI()
            }
        }
    }
    
    func notVehicleInvolvedAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"other vehicle involved","token":token,"sender":senderId]
        chatDataVM.notVehicleInvolvedApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }

    func otherVehicleNoAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        var param = ["":""]
        if isInvolved == false {
            param = ["message": "no","token":token,"sender":senderId]
        } else {
            param = ["message":self.messageTextField.text ?? "","token":token,"sender":senderId]
        }
        chatDataVM.otherVehicleNoApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            UserDefaults.standard.set(true, forKey: Global.UDKeys.InVolvedVehicle)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }
    
    func undoMessageAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["token":token,"sender":senderId]
        chatDataVM.undoChatApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }

    func needCurtosyCarAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        self.isInvolved = false
        var param = ["":""]
        if self.isNoCurtosyCar == true {
            param = ["message": "yes","token":token,"sender":senderId]
        } else {
            param = ["message": "no","token":token,"sender":senderId]
        }
        chatDataVM.curtosyCarApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }

    func faultScenarioAPI(scenario : [String:Any]){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["fault":"yes","message":"Select scenario","scenario_id":scenario["id"] as? String ?? "","scenario_title":scenario["title"] as? String ?? "","scenario_url":scenario["imageUrl"] as? String ?? "","token":token,"sender":senderId]
        chatDataVM.scenarioFaultApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }
    
    func noFaultScenarioAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["token":token,"sender":senderId]
        chatDataVM.scenarioNoFaultApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }
    
    func accidentLocationAPI(lat: String, long:String){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"location access","latitude":lat,"longitude":long,"location_name":"Location","token":token,"sender":senderId]
        chatDataVM.accidentLocationApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }

    func confirmLocationAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"yes","token":token,"sender":senderId,"device":"ios"]
        chatDataVM.confirmLocationApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }

    func noCameraAccessAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["message":"no","token":token,"sender":senderId]
        chatDataVM.noCameraAccessApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self?.initialMessageAPI()
            }
        }
    }
    
    func openWebUrlAPI(){
        SKActivityIndicator.show("Loading...")
        self.view.isUserInteractionEnabled = false
        let param = ["token":token,"sender":senderId]
        chatDataVM.openWebUrlApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.async {
                let cellData = self?.chatDataVM.openWebData
                self?.webMessageLbl.text = cellData?.message ?? ""
//                self?.webURLView.isHidden = false
//                self?.webURLViewHeightCons.constant = 50
            }
        }
    }
    
    //MARK: Button
    @IBAction func sendMessageButton_Tapped(_ sender: UIButton){
        messageTextField.resignFirstResponder()
        if (messageTextField.text?.stripped.count)!>1{
            let number =   VRMValidator().validate(vrm: messageTextField.text!)
            var striped = messageTextField.text?.removingWhitespaces().stripped
            let index = striped?.index(striped!.startIndex, offsetBy: 4)
            striped?.insert(" ", at: index!)
            if number {
                messageTextField.text = striped?.uppercased()
                if self.messageTextField.text != "" {
                    otherVehicleNoAPI()
                } else {
                    Loaf("Enter message..", state: .custom(.init(backgroundColor: .systemRed)), location: .bottom, presentingDirection: .left, dismissingDirection: .right, sender: self).show(.short)
                }
            }
        }
    }
    
    @IBAction func undoButton_Tapped(_ sender: UIButton){
        self.undoMessageAPI()
    }
    
    @IBAction func backButton_Tapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func webViewTapped(_ sender: UIButton){
        
    }
    
    @objc func cameraYesTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebPageViewController") as! WebPageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func cameraNoTapped(_ sender: UIButton) {
        self.noCameraAccessAPI()
    }
    
    @objc func locationYesTapped(_ sender: UIButton) {
        self.confirmLocationAPI()
    }
    
    @objc func locationNoTapped(_ sender: UIButton) {
        self.confirmLocationAPI()
    }
    
    @objc func curstosyCarYesTapped(_ sender: UIButton) {
        self.isNoCurtosyCar = true
        self.needCurtosyCarAPI()
    }
    
    @objc func curstosyCarNoTapped(_ sender: UIButton) {
        self.isNoCurtosyCar = false
        self.needCurtosyCarAPI()
    }
    
    @objc func scenarioOkTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccidentScenarioViewController") as! AccidentScenarioViewController
        let isInVolving = UserDefaults.standard.bool(forKey: Global.UDKeys.InVolvedVehicle)
        if isInVolving == true {
            vc.isTwoScenario = true
        } else {
            vc.isTwoScenario = false
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func locationOkTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapsViewController") as! MapsViewController
        vc.del = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func involveOtherVTapped(_ sender: UIButton) {
        self.isInvolved = true
        self.vehicleInvolvedAPI()
    }
    
    @objc func notInvolveVTapped(_ sender: UIButton) {
        self.isInvolved = false
        self.otherVehicleNoAPI()
    }
    
    @objc func confirmVNoTapped(_ sender: UIButton) {
        self.isForConfirm = 2
        self.initiateClaimAPI()
    }
    
    @objc func emergencyTapped(_ sender: UIButton) {
        print("Emergency Tapped")
        if let url = URL(string: "tel://\("10")"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func claimTapped(_ sender: UIButton) {
        print("Claim Tapped")
        self.isForConfirm = 1
        self.initiateClaimAPI()
    }
    
    
}
extension ChatAssistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.chatDataVM.chatsData != nil {
            return self.chatDataVM.chatsData.chatHistory.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.chatDataVM.chatsData != nil {
//            let lastIndexPath = chatAssistTableView.lastIndexpath()
//            if (lastIndexPath.last != nil) {
//                if lastIndexPath.last == indexPath.row{
//                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
//                } else {
//
//                }
//            }
            let cellData = self.chatDataVM.chatsData.chatHistory[indexPath.row]
            if cellData.step == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "BotDoubleCommentTableViewCell", for: indexPath) as? BotDoubleCommentTableViewCell{
                    cell.titleLabel.text = cellData.chatResponse.text ?? ""
                    cell.emergencyButton.setTitle(cellData.chatResponse.buttons[0].title, for: .normal)
                    cell.claimButton.setTitle(cellData.chatResponse.buttons[1].title, for: .normal)
//                    cell.emergencyButton.tag = indexPath.row
                    cell.emergencyButton.addTarget(self, action: #selector(emergencyTapped(_:)), for: .touchUpInside)
                    cell.claimButton.addTarget(self, action: #selector(claimTapped(_:)), for: .touchUpInside)
                    if #available(iOS 15, *) {
                        cell.timeLabel.text = cellData.timeStamp.formatDateString()
                    } else {
                        // Fallback on earlier versions
                    }
                    return cell
                }
            }
            if cellData.step == 3 {
                if cellData.step ?? 0 > 2 {
                    self.undoButton.isHidden = false
                } else {
                    self.undoButton.isHidden = true
                }
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTextTableViewCell", for: indexPath) as? UserTextTableViewCell{
                        cell.confirmButton.setTitle("Confirm", for: .normal)
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        if cellData.chatResponse.buttons != nil{
                            cell.titleLabel.attributedText = cellData.chatResponse.text.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Avenir-Book", size: 16), csscolor: "black", lineheight: 5, csstextalign: "Left")
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
//                            cell.confirmButton.tag = indexPath.row
                            cell.confirmButton.addTarget(self, action: #selector(confirmVNoTapped(_:)), for: .touchUpInside)
                            
                        }
                        
                        return cell
                    }
                }
            }
            if  cellData.step == 4 {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTextDoubleCommentTableViewCell", for: indexPath) as? UserTextDoubleCommentTableViewCell{
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse != nil{
                            cell.titleLabel.text = cellData.chatResponse.text ?? ""
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.acceptButton.setTitle(cellData.chatResponse.buttons[0].title, for: .normal)
                            cell.declineButton.setTitle(cellData.chatResponse.buttons[1].title, for: .normal)
                            cell.acceptButton.addTarget(self, action: #selector(involveOtherVTapped(_:)), for: .touchUpInside)
                            cell.declineButton.addTarget(self, action: #selector(notInvolveVTapped(_:)), for: .touchUpInside)
                        }
                        return cell
                    }
                }
            }
            if cellData.step == 5 {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserText4TableViewCell", for: indexPath) as? UserText4TableViewCell{
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse.buttons != nil{
                            cell.titleLabel.text = cellData.chatResponse.text
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.confirmButton.isHidden = true
                            //                                cell.confirmButton.setTitle("Confirm", for: .normal)
                        }
                        return cell
                    }
                }
            }
            if  cellData.step == 6 {
                if cellData.userResponse != nil{
                    self.messageView.isHidden = true
                    self.messageViewHeightCons.constant = 0
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTextDoubleActionTableViewCell", for: indexPath) as? UserTextDoubleActionTableViewCell{
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse != nil{
                            cell.titleLabel.text = cellData.chatResponse.text ?? ""
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.acceptButton.setTitle(cellData.chatResponse.buttons[0].title, for: .normal)
                            cell.declineButton.setTitle(cellData.chatResponse.buttons[1].title, for: .normal)
//                            cell.acceptButton.tag = indexPath.row
                            cell.acceptButton.addTarget(self, action: #selector(curstosyCarYesTapped(_:)), for: .touchUpInside)
//                            cell.declineButton.tag = indexPath.row
                            cell.declineButton.addTarget(self, action: #selector(curstosyCarNoTapped(_:)), for: .touchUpInside)
                        }
                        return cell
                    }
                }
            }
            if cellData.step == 7 {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserText6TableViewCell", for: indexPath) as? UserText6TableViewCell{
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        cell.confirmButton.setTitle(cellData.chatResponse.buttons[0].title, for: .normal)
                        if cellData.chatResponse.buttons != nil{
                            cell.titleLabel.text = cellData.chatResponse.text
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
//                            cell.confirmButton.tag = indexPath.row
                            cell.confirmButton.addTarget(self, action: #selector(scenarioOkTapped(_:)), for: .touchUpInside)
                            
                        }
                        return cell
                    }
                }
            }
            if cellData.step == 8 || cellData.step == Int(8.1){
                if cellData.step == 8 {
                    if cellData.userResponse != nil{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTextWImageTableViewCell", for: indexPath) as? UserTextWImageTableViewCell{
                            let scenarioContent = [String:Any]()
                            self.recoverEmpty(Scene: scenarioContent)
                            if cellData.userResponse.imageTitle == "" {
                                cell.titleLbl.text = scenarioContent["title"] as? String ?? ""
                                cell.scenarioImg.loadImage(string: scenarioContent["imageUrl"] as? String ?? "")
                            } else {
                                cell.titleLbl.text = cellData.userResponse.imageTitle ?? ""
                                cell.scenarioImg.loadImage(string: cellData.userResponse.imageUrl ?? "")
                            }
                            if #available(iOS 15, *) {
                                cell.userTimeLbl.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            if cellData.chatResponse.buttons != nil{
                                cell.confirmLabel.text = cellData.chatResponse.text
                                if #available(iOS 15, *) {
                                    cell.botTimeLbl.text = cellData.timeStamp.formatDateString()
                                } else {
                                    // Fallback on earlier versions
                                }
                                cell.okButton.isHidden = false
                                cell.okButton.setTitle("OK", for: .normal)
                                cell.okButton.addTarget(self, action: #selector(locationOkTapped(_:)), for: .touchUpInside)
                            }
                            return cell
                        }
                    }
                } else if cellData.step == Int(8.1) {
                    if cellData.userResponse != nil{
                        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserText8TableViewCell", for: indexPath) as? UserText8TableViewCell{
                            cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                            if #available(iOS 15, *) {
                                cell.dateLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            if cellData.chatResponse.buttons != nil{
                                cell.titleLabel.text = cellData.chatResponse.text
                                if #available(iOS 15, *) {
                                    cell.timeLabel.text = cellData.timeStamp.formatDateString()
                                } else {
                                    // Fallback on earlier versions
                                }
                                cell.confirmButton.isHidden = true
                                //                                cell.confirmButton.setTitle("Confirm", for: .normal)
                            }
                            return cell
                        }
                    }
                }
            }
            if  cellData.step == 9 {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTextDoubleAction9TableViewCell", for: indexPath) as? UserTextDoubleAction9TableViewCell{
                        cell.userTitleLabel.text = "\(cellData.userResponse.text ?? "")"
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse != nil{
                            cell.titleLabel.text = cellData.chatResponse.text ?? ""
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.acceptButton.setTitle("Yes", for: .normal)
                            cell.declineButton.setTitle("No", for: .normal)
                            cell.acceptButton.addTarget(self, action: #selector(locationYesTapped(_:)), for: .touchUpInside)
                            cell.declineButton.addTarget(self, action: #selector(locationNoTapped(_:)), for: .touchUpInside)
                        }
                        return cell
                    }
                }
            }
            if cellData.step == 10 {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserDoubleAction10TableViewCell", for: indexPath) as? UserDoubleAction10TableViewCell{
                        cell.userTitleLabel.text = "\(cellData.userResponse.text ?? "")"
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse != nil{
                            cell.titleLabel.text = cellData.chatResponse.text ?? ""
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.acceptButton.setTitle("Yes", for: .normal)
                            cell.acceptButton.addTarget(self, action: #selector(cameraYesTapped(_:)), for: .touchUpInside)
                            cell.declineButton.setTitle("No", for: .normal)
                            cell.declineButton.addTarget(self, action: #selector(cameraNoTapped(_:)), for: .touchUpInside)
                        }
                        return cell
                    }
                }
            }
            if "\(cellData.step ?? 0)" == String("9.1") {
                if cellData.userResponse != nil{
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserText11TableViewCell", for: indexPath) as? UserText11TableViewCell{
                        cell.userTitleLabel.text = cellData.userResponse.text ?? ""
                        if #available(iOS 15, *) {
                            cell.dateLabel.text = cellData.timeStamp.formatDateString()
                        } else {
                            // Fallback on earlier versions
                        }
                        if cellData.chatResponse.buttons != nil{
                            cell.titleLabel.text = cellData.chatResponse.text
                            if #available(iOS 15, *) {
                                cell.timeLabel.text = cellData.timeStamp.formatDateString()
                            } else {
                                // Fallback on earlier versions
                            }
                            cell.confirmButton.isHidden = true
//                            cell.confirmButton.addTarget(self, action: #selector(cameraYesTapped(_:)), for: .touchUpInside)
                            //                                cell.confirmButton.setTitle("Confirm", for: .normal)
                        }
                        return cell
                    }
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = self.chatDataVM.chatsData.chatHistory[indexPath.row]
        if count != nil {
            let cellData = self.chatDataVM.chatsData.chatHistory[indexPath.row]
            if cellData.step == 1 {
                return 235.0
            }
            if cellData.step == 3  {
                if cellData.chatResponse.buttons != nil{
                    return 250.0
                } else {
                    return 60.0
                }
                
            }
            if cellData.step == 4 || cellData.step == 6 || cellData.step == 7{
                if cellData.chatResponse.buttons != nil{
                    return 280.0
                } else {
                    return 60.0
                }
            }
            if cellData.step == 5 {
                if cellData.chatResponse.buttons != nil{
                    return 175.0
                } else {
                    return 60.0
                }
                
            }
            if cellData.step == 8{
                if cellData.chatResponse.buttons != nil{
                    return 385.0
                } else {
                    return 60.0
                }
            } else if cellData.step == Int(8.1){
                if cellData.chatResponse.buttons != nil{
                    return 260.0
                } else {
                    return 60.0
                }
            }
            if cellData.step == 9 || cellData.step == 10 {
                if cellData.chatResponse.buttons != nil{
                    return 280.0
                } else {
                    return 60.0
                }
            }
            if "\(cellData.step ?? 0)" == String(9.1){
                if cellData.chatResponse.buttons != nil{
                    return 280.0
                } else {
                    return 60.0
                }
                
            }
        }
        return 70.0
    }
}
