//
//  LoginModel.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import Foundation
import SwiftyJSON

class LoginDataModel{
    var companyId : Int!
    var email : String!
    var name : String!
    var status : String!
    var token : String!
    var userId : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        companyId = json["company_id"].intValue
        email = json["email"].stringValue
        name = json["name"].stringValue
        status = json["status"].stringValue
        token = json["token"].stringValue
        userId = json["user_id"].intValue
    }
}
