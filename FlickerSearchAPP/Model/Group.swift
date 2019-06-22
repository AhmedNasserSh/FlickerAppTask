//
//  Group.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class Group :BaseModel {
    var farm : Int?
    var id : String?
    var server : String?
    var secret : String?
    var name : String?
    var members :String?
    var poolCount :String?
    var topicCount :String?

    override func mapping(map: Map) {
        LoggerRepo.logInfo("Group:mapping")
        LoggerRepo.logDebug("Group:mapping ,Parmters:(map: Map)")
        farm <- map["iconfarm"]
        id <- map["nsid"]
        server <- map["iconserver"]
        secret <- map["secret"]
        name <- map["name"]
        members <- map["members"]
        poolCount <- map["pool_count"]
        topicCount <- map["topic_count"]
    }

    func getGroupIconURL(_ size:String = "m") -> URL? {
        LoggerRepo.logInfo("Group:getGroupIconURL")
        LoggerRepo.logDebug("Group:getGroupIconURL ,Parmters:(_ size:String = m)")
        guard let i = id  else{ return nil}
        if let url =  URL(string: "https://flickr.com/buddyicons/\(i).jpg") {
            return url
        }
        return nil
    }
    
}
