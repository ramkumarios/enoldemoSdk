//
//  LoginViewModel.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import Foundation
import SwiftyJSON

class LoginViewModel {
    init(model: LoginDataModel? = nil){
        if let Loginmodel = model{
            loginData = Loginmodel
        }
    }
    var loginData : LoginDataModel!
}
extension LoginViewModel {
    func loginApiCall(parameter: [String: String], completion: @escaping (Result<LoginDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.loginAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = LoginDataModel.init(fromJson: JSON(dta))
                self.loginData = rootclass
                if let responseData = self.loginData{
                    completion(.success(responseData))
                }
            }
        }
    }
}
