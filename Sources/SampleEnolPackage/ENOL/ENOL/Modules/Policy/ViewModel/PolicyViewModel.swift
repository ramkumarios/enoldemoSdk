//
//  PolicyViewModel.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import Foundation
import SwiftyJSON


class PolicyViewModel{
    init(model: PolicyDetails? = nil){
        if let PolicyModel = model{
            PolicyData = PolicyModel
        }
    }
    var PolicyData : PolicyDetails!
}
extension PolicyViewModel{
    func policyListApiCall(completion: @escaping ([PolicyDetails]) -> ()) {
        
        Service.shared.get(urlString: Global.WebAPI.policyListAPI + (UserDefaults.standard.string(forKey: Global.UDKeys.Token) ?? "")) { [weak self] result in
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
    func didRecievePolicyDetails(policyDetails: Data) -> [PolicyDetails]?{
        do{
            let decoder = JSONDecoder()
            let policyList = try decoder.decode([PolicyDetails].self, from: policyDetails)
          //  completion(policyList)
            return policyList
        }catch{
                print(error)
            }
        return nil
         
    }
}
