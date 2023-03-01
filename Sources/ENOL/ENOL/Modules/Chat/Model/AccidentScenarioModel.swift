//
//  AccidentScenarioModel.swift
//  ENOL
//
//  Created by TVPC000013 on 09/02/23.
//

import Foundation
import SwiftyJSON

struct ScenarioDataModel: Codable {
    
    var displayText: String?
    var url: String?
    var step: Double?
    var timeStamp: String?
    var vehicleInvolvedScenarios: [VehicleInvolvedScenarios]?

    private enum CodingKeys: String, CodingKey {
        case displayText = "display_text"
        case url = "url"
        case step = "step"
        case timeStamp = "time_stamp"
        case vehicleInvolvedScenarios = "vehicleInvolvedScenarios"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        displayText = try values.decodeIfPresent(String.self, forKey: .displayText)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        step = try values.decodeIfPresent(Double.self, forKey: .step)
        timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp)
        vehicleInvolvedScenarios = try values.decodeIfPresent([VehicleInvolvedScenarios].self, forKey: .vehicleInvolvedScenarios)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(displayText, forKey: .displayText)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(timeStamp, forKey: .timeStamp)
        try container.encodeIfPresent(vehicleInvolvedScenarios, forKey: .vehicleInvolvedScenarios)
    }

}
struct VehicleInvolvedScenarios : Codable {
    
    var first: First?
    var second: Second?

    private enum CodingKeys: String, CodingKey {
        case first = "first"
        case second = "second"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first = try values.decodeIfPresent(First.self, forKey: .first)
        second = try values.decodeIfPresent(Second.self, forKey: .second)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(first, forKey: .first)
        try container.encodeIfPresent(second, forKey: .second)
    }

}
struct First : Codable {
    
    var id: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var isAtFault: Bool?
    var isOtherVehicleInvolved: Bool?
    var faultTitle: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case imageUrl = "imageUrl"
        case isAtFault = "isAtFault"
        case isOtherVehicleInvolved = "isOtherVehicleInvolved"
        case faultTitle = "faultTitle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        isAtFault = try values.decodeIfPresent(Bool.self, forKey: .isAtFault)
        isOtherVehicleInvolved = try values.decodeIfPresent(Bool.self, forKey: .isOtherVehicleInvolved)
        faultTitle = try values.decodeIfPresent(String.self, forKey: .faultTitle)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(isAtFault, forKey: .isAtFault)
        try container.encodeIfPresent(isOtherVehicleInvolved, forKey: .isOtherVehicleInvolved)
        try container.encodeIfPresent(faultTitle, forKey: .faultTitle)
    }

}

struct Second : Codable {
    
    var id: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var isAtFault: Bool?
    var isOtherVehicleInvolved: Bool?
    var faultTitle: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case imageUrl = "imageUrl"
        case isAtFault = "isAtFault"
        case isOtherVehicleInvolved = "isOtherVehicleInvolved"
        case faultTitle = "faultTitle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        isAtFault = try values.decodeIfPresent(Bool.self, forKey: .isAtFault)
        isOtherVehicleInvolved = try values.decodeIfPresent(Bool.self, forKey: .isOtherVehicleInvolved)
        faultTitle = try values.decodeIfPresent(String.self, forKey: .faultTitle)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(isAtFault, forKey: .isAtFault)
        try container.encodeIfPresent(isOtherVehicleInvolved, forKey: .isOtherVehicleInvolved)
        try container.encodeIfPresent(faultTitle, forKey: .faultTitle)
    }

}
