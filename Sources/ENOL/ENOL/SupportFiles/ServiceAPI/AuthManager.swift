//
//  AuthManager.swift
//  ENOL
//
//  Created by TVPC000013 on 10/02/23.
//

import Foundation
import Alamofire

class AuthManager{
    class func getRequest(urlString: String, isAuth:Bool = false, completionHandler: @escaping (Bool, String, Data?, Error?) -> Swift.Void) -> () {
        
        var header = [String: String]()
        
        header = ["Content-Type": "application/json"]
        Alamofire.request(urlString, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            switch response.result {
            case .success:
                print("getRequest", response)
                if let responseVal = response.result.value as? [String: AnyObject] {
                    completionHandler(true, "Success", response.data ?? Data.init(), response.error)
                }
                break
            case .failure(let error):
                completionHandler(false, "Error", response.data ?? Data.init(), error)
            }
        }
    }
}
