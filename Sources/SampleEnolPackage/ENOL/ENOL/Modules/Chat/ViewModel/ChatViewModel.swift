//
//  ChatViewModel.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import Foundation
import SwiftyJSON

class ChatViewModel {
    init(model : ChatDataModel? = nil, inmodel: openWebDataClass? = nil ){
        if let ChatData = model{
            chatsData = ChatData
        }
        if let webData = inmodel{
            openWebData = webData
        }
    }
    var chatsData : ChatDataModel!
    var openWebData : openWebDataClass!
}
extension ChatViewModel{
    func chatDataApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.firstChatAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func chatClaimApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.initateAClaimAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func confirmVNumberApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.confirmVehicleNoAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func otherVehicleInvolvedApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.confirmOtherCarInvolvedAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func notVehicleInvolvedApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.OtherVehicleNotInvolveAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func undoChatApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.undoBtnAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func otherVehicleNoApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.otherVehicleNoAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func curtosyCarApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.curtosyCarAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    func scenarioFaultApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.selectScenarioFaultAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func scenarioNoFaultApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.selectNoFaultScenarioAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func accidentLocationApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.locationAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func confirmLocationApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.confirmLocationAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    func noCameraAccessApiCall(parameter: [String: Any], completion: @escaping (Result<ChatDataModel, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.noCameraAccessAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = ChatDataModel.init(fromJson: JSON(dta))
                self.chatsData = rootclass
                if let responseData = self.chatsData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    func openWebUrlApiCall(parameter: [String: Any], completion: @escaping (Result<openWebDataClass, Error> ) -> Void) {
        
        Service.shared.post(urlString: Global.WebAPI.openWebURLAPI , param: parameter) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let rootclass = openWebDataClass.init(fromJson: JSON(dta))
                self.openWebData = rootclass
                if let responseData = self.openWebData{
                    completion(.success(responseData))
                }
            }
        }
    }
    
    
}
