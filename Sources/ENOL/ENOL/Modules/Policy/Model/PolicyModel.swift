//
//  PolicyModel.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import Foundation
import SwiftyJSON

struct PolicyDetails:Codable{
    var policy_id: Int
    var policyImage: String
    var vehicleName: String
    var vehicleRegistrationNumber: String
    var dateOfValidity: String
    var productName: String
    var policy_premium:String
    var vehicleValue: String
    var policyStartDate: String
    var policyEndDate: String
    var policyNumber: String
    var noClaimBonus: String
    var policy_isactive: Int
    var policy_type: Int
    var user_id: Int
    var sender_id: String
}
struct PolicyListResponse:Codable{
    var response: [PolicyDetails]
    var responseStatus:String
    var responseMessage:String
    var responseIsSuccess:Bool
    
}

