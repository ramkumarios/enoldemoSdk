//
//  LoginViewController.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import UIKit
import SKActivityIndicatorView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginVM = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Initial
    func initialSetup(){
        
    }
    
    func loginAPI(){
        SKActivityIndicator.show("Logging In...")
        let param = ["username":self.userNameTextField.text ?? "","password": self.passwordTextField.text ?? ""]
        loginVM.loginApiCall(parameter: param){[weak self] breaches in
            SKActivityIndicator.dismiss()
            DispatchQueue.main.async {
                let cellData = self?.loginVM.loginData
                if cellData?.status == Global.ErrorCodes.NoError{
                    UserDefaults.standard.set(cellData?.token, forKey: Global.UDKeys.Token)
                    UserDefaults.standard.set(cellData?.userId, forKey: Global.UDKeys.UserId)
                    UserDefaults.standard.set(cellData?.name, forKey: Global.UDKeys.UserName)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController
                        self?.navigationController?.pushViewController(vc!, animated: true)
                    }
                } else {
                    print("asdf")
                    self?.openAlert(title: "Warning", message: "Something went wrong!", alertStyle: .alert, actionTitles: ["Ok"], actionStyles: [.default], actions: [ {_ in
                        
                    }])
                }
            }
        }
    }
    
    //MARK: Button Action
    @IBAction func loginButton_Tapped(_ sender: UIButton){
        self.isValidation()
    }
    
    func isValidation(){
        if userNameTextField.text!.isEmpty {
            Loaf("Enter Username", state: .custom(.init(backgroundColor: .systemRed)), location: .bottom, presentingDirection: .left, dismissingDirection: .right, sender: self).show(.short)
            return
        } else if passwordTextField.text == "" {
            Loaf("Enter Password", state: .custom(.init(backgroundColor: .systemRed)), location: .bottom, presentingDirection: .left, dismissingDirection: .right, sender: self).show(.short)
            return
        } else {
            self.loginAPI()
        }
    }


}
