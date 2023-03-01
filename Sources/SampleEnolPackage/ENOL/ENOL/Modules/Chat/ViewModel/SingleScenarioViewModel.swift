//
//  SingleScenarioViewModel.swift
//  ENOL
//
//  Created by TVPC000013 on 10/02/23.
//

import Foundation
import SwiftyJSON

class SingleScenarioViewModel{
//    init(model: SingleSceneDataModel? = nil){
//        if let PolicyModel = model{
//            PolicyData = PolicyModel
//        }
//    }
//    var PolicyData : SingleSceneDataModel!
}
extension SingleScenarioViewModel{
    func SingleScenarioApiCall(completion: @escaping ([VehicleNotInvolvedScenarios]) -> ()) {
        
        Service.shared.get(urlString: Global.WebAPI.SingleScenarioFaultAPI + (UserDefaults.standard.string(forKey: Global.UDKeys.Token) ?? "")) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case let .success(data):
                let policyListResponse = self.didRecievePolicyDetails(policyDetails: data)
                if policyListResponse != nil {
                    completion(policyListResponse!)
                }
                
            case let .failure(error):
                print("ASGasasfda \(error.localizedDescription)")

            }
        }
    }
    func didRecievePolicyDetails(policyDetails: Data) -> [VehicleNotInvolvedScenarios]?{
        do{
            let decoder = JSONDecoder()
            let policyList = try decoder.decode([VehicleNotInvolvedScenarios].self, from: policyDetails)
          //  completion(policyList)
            return policyList
        }catch{
                print(error)
            }
        return nil
         
    }
}

