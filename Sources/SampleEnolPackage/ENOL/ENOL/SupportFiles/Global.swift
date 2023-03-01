//
//  Global.swift
//  ENOL
//
//  Created by TVPC000013 on 06/02/23.
//
// Global files is for API Base Url and LocalDB(Userdefaults)

import Foundation
import UIKit

class Global : NSObject {
    static let appName = "ENOL"
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let BaseURL = "https://identity.enol.ai/" //Production
    static let BaseChatURL = "https://multipleapi.enol.ai/v2/" //Production Chat(happy path)
}
extension Global {
    struct WebAPI {
        static let loginAPI = BaseURL + "login"
        static let policyListAPI = BaseURL + "GetAllPolicy?token="
        static let policyIDAPI = BaseURL + ""
        
        static let firstChatAPI = BaseChatURL + "first/"
        static let emergencyInitialAPI = BaseChatURL + "emergency/"
        static let initateAClaimAPI = BaseChatURL + "initializeclaim/"
        static let confirmVehicleNoAPI = BaseChatURL + "confirmvno/"
        static let confirmOtherCarInvolvedAPI = BaseChatURL + "othervehicleinvolved/"
        static let OtherVehicleNotInvolveAPI = BaseChatURL + "otherVehicleNoNot/"
        static let otherVehicleNoAPI = BaseChatURL + "othervehicleno/"
        static let curtosyCarAPI = BaseChatURL + "curtosycar/"
        static let undoBtnAPI = BaseChatURL + "undobutton/"
        static let locationAPI = BaseChatURL + "location/"
        static let confirmLocationAPI = BaseChatURL + "confirmlocation/"
        static let scenarioAPI = BaseChatURL + "scenario_above/"
        static let selectScenarioFaultAPI = BaseChatURL + "selectscenario/"
        static let selectNoFaultScenarioAPI = BaseChatURL + "nonfaultok/"
        static let noCameraAccessAPI = BaseChatURL + "cameraaccessno/"
        static let accessCameraAPI = BaseChatURL + "accesscamera/"
        static let cameraImagesOkAPI = BaseChatURL + "cameraimageok/"
        
        static let openWebURLAPI = BaseChatURL + "goToWebUi/"
        
        static let TwoScenarioFaultAPI = BaseChatURL + "scenarioid/?other_vehicle_invloved=yes&token="
        static let SingleScenarioFaultAPI = BaseChatURL + "scenarioid/?other_vehicle_invloved=no&token="
    }
    
    struct ErrorCodes {
        
        static let NoError = "Success"
        static let Error = "Failure"
        static let SessionOut = "5"
        
    }
    
    struct UDKeys{
        static let Token = "Token"
        static let UserId = "UserId"
        static let UserName = "UserName"
        static let SenderId = "SenderId"
        static let PolicyId = "PolicyId"
        static let VehicleNumber = "VehicleNumber"
        static let InVolvedVehicle = "InVolvedVehicle"
    }
    
    struct Font {
        
        static let SYSTEMBOLD = "system-Bold"
        static let SYSTEMHEAVY = "system-ExtraBold"
        static let SYSTEMLIGHT = "system-Light"
        static let SYSTEMMEDIUM = "system-Regular"
        
    }
}
public func jsonArray(data: Data) -> [String: Any] {
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonArray = jsonResponse as? [String: Any] else {
            return [:]
        }
        return jsonArray
    } catch(let error) {
        print(error)
        return [:]
    }
}
