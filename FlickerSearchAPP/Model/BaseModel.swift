//
//  BaseModel.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseModel :Mappable {
    var statCode:Int?
    var stat :String?
    var message:String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        statCode <- map["code"]
        stat <- map["stat"]
        message <- map["message"]
    }
    
}
