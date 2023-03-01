//
//  AccidentScenarionViewModel.swift
//  ENOL
//
//  Created by TVPC000013 on 09/02/23.
//

import Foundation
import SwiftyJSON

class AccidentScenarioViewModel{
    init(model: ScenarioDataModel? = nil){
        if let Scenariomodel = model {
            scanerioData = Scenariomodel
        }
    }
    var scanerioData : ScenarioDataModel!
}
extension AccidentScenarioViewModel{
    func twoScenarioApiCall(completion: @escaping ([VehicleInvolvedScenarios]) -> ()){
        
        Service.shared.get(urlString: "\(Global.WebAPI.TwoScenarioFaultAPI)\(UserDefaults.standard.string(forKey: Global.UDKeys.Token) ?? "")") { [weak self] result in
            guard let self = self else {return}
            switch result{
            case let .success(data):
                let policyListResponse = self.didRecieveScenarioDetails(scenarioDetails: data)
                if policyListResponse != nil {
                    completion(policyListResponse!)
                }
                
            case let .failure(error):
                print("ASGasasfda \(error.localizedDescription)")

            }
        }
    }
    
    func didRecieveScenarioDetails(scenarioDetails: Data) -> [VehicleInvolvedScenarios]?{
        do{
            let decoder = JSONDecoder()
            let scanerioList = try decoder.decode([VehicleInvolvedScenarios].self, from: scenarioDetails)
            print("scenarioListArray!",scenarioDetails)
            return scanerioList
        }catch{
                print(error)
            }
        return nil
         
    }
}
