//
//  ProfileViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 22/02/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: intial Setup
    func intialSetup(){
        self.userNameLabel.text = UserDefaults.standard.string(forKey: Global.UDKeys.UserName)
    }
    
    @IBAction func logoutBtn_Tapped(_ sender: UIButton){
//        Global.appDelegate.loginVC()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    


}
