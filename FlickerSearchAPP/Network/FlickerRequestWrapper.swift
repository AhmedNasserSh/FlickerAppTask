//
//  FlickerRequestWrapper.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
class FlickerRequestWrapper {
    static func getBody(service :FlickerAPIManger) -> [String:Any]? {
        LoggerRepo.logInfo("FlickerRequestWrapper:getBody")
        LoggerRepo.logDebug("FlickerRequestWrapper:getBody ,Parmters:(service :FlickerAPIManger) ->  [String:Any]?")
        switch service {
        case .getImages(let query,let page):
            return  ["method": SearchMethod.images.rawValue , "api_key": APIConstant.flickerApiKey, "tags":query, "format":"json", "nojsoncallback": 1 ,"in_gallery" :1 ,"per_page" :20,"page":page ]
        case .getGroups(let query,let page):
            return  ["method": SearchMethod.groups.rawValue, "api_key": APIConstant.flickerApiKey, "text":query, "format":"json", "nojsoncallback": 1 ,"per_page" :20,"page":page]
        default:
            // download image
            return nil
        }
    }
}
