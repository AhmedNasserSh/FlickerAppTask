//
//  Group.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class Group :Mappable {
    var farm : Int?
    var id : String?
    var server : String?
    var secret : String?
    var name : String?
    var members :String?
    var poolCount :String?
    var topicCount :String?
    
    init() {
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
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
        guard let i = id  else{ return nil}
        if let url =  URL(string: "https://flickr.com/buddyicons/\(i).jpg") {
            return url
        }
        return nil
    }
    
}
