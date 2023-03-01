//
//  SingleScenarioModel.swift
//  ENOL
//
//  Created by TVPC000013 on 10/02/23.
//

import Foundation

struct SingleSceneDataModel : Codable {

    var displayText: String?
    var url: String?
    var step: Double?
    var timeStamp: String?
    var vehicleNotInvolvedScenarios: [VehicleNotInvolvedScenarios]?

}

class VehicleNotInvolvedScenarios: Codable {

    var id: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var isAtFault: Bool?
    var isOtherVehicleInvolved: Bool?

}
