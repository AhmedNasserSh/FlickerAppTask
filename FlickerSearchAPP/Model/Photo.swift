//
//  SearchItem.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class Photo : BaseModel {
    var farm : Int?
    var id : String?
    var server : String?
    var secret : String?
    var image :UIImage?
    
    override func mapping(map: Map) {
        LoggerRepo.logInfo("Photo:mapping")
        LoggerRepo.logDebug("Photo:mapping ,Parmters:(map: Map)")
        farm <- map["farm"]
        id <- map["id"]
        server <- map["server"]
        secret <- map["secret"]
    }

    func getImageURL(_ size:String = "m") -> URL? {
        LoggerRepo.logInfo("Photo:getImageURL")
        LoggerRepo.logDebug("Photo:mapping ,Parmters:(_ size:String = m)")
        guard let f = farm , let s = server ,let i = id ,let c = secret else{ return nil}
        if let url =  URL(string: "https://farm\(f).staticflickr.com/\(s)/\(i)_\(c)_\(size).jpg") {
            return url
        }
        return nil
    }
}
