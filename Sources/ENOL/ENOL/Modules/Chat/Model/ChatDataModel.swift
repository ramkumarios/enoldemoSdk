//
//  ChatDataModel.swift
//  ENOL
//
//  Created by TVPC000013 on 08/02/23.
//

import Foundation
import SwiftyJSON

class ChatDataModel{
    
    var chatHistory : [ChatHistory]!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        chatHistory = [ChatHistory]()
        let chatHistoryArray = json["chat_history"].arrayValue
        for chatHistoryJson in chatHistoryArray{
            let value = ChatHistory(fromJson: chatHistoryJson)
            chatHistory.append(value)
        }
    }
}
class ChatHistory{
    
    var chatResponse : ChatResponse!
    var step : Int!
    var timeStamp : String!
    var userResponse : UserResponse!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        let chatResponseJson = json["chat_response"]
        if chatResponseJson != JSON.null{
            chatResponse = ChatResponse(fromJson: chatResponseJson)
        }
        step = json["step"].intValue
        timeStamp = json["time_stamp"].stringValue
        let userResponseJson = json["user_response"]
        if userResponseJson != JSON.null{
            userResponse = UserResponse(fromJson: userResponseJson)
        }
    }
    
}
class UserResponse{
    
    var location : [Location]!
    var button : String!
    var imageTitle : String!
    var imageUrl : String!
    var scenarioId : String!
    var text : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        location = [Location]()
        let buttonsArray = json["location"].arrayValue
        for buttonsJson in buttonsArray{
            let value = Location(fromJson: buttonsJson)
            location.append(value)
        }
        button = json["button"].stringValue
        imageTitle = json["image_title"].stringValue
        imageUrl = json["image_url"].stringValue
        scenarioId = json["scenario_id"].stringValue
        text = json["text"].stringValue
    }
    
}
class ChatResponse{
    
    var buttons : [Button]!
    var text : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        buttons = [Button]()
        let buttonsArray = json["buttons"].arrayValue
        for buttonsJson in buttonsArray{
            let value = Button(fromJson: buttonsJson)
            buttons.append(value)
        }
        text = json["text"].stringValue
    }
    
}
class Button{
    
    var payload : String!
    var step : Int!
    var title : String!
    var url : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        payload = json["payload"].stringValue
        step = json["step"].intValue
        title = json["title"].stringValue
        url = json["url"].stringValue
    }
    
}
class Location{
    
    var latitude : String!
    var locationName : String!
    var longitude : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        latitude = json["latitude"].stringValue
        locationName = json["location_name"].stringValue
        longitude = json["longitude"].stringValue
    }
    
}
class openWebDataClass{

    var message : String!
    var status : Int!
    var step : Int!
    var timestamp : [String]!
    var weblink : String!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        message = json["message"].stringValue
        status = json["status"].intValue
        step = json["step"].intValue
        timestamp = [String]()
        let timestampArray = json["timestamp"].arrayValue
        for timestampJson in timestampArray{
            timestamp.append(timestampJson.stringValue)
        }
        weblink = json["weblink"].stringValue
    }

}
