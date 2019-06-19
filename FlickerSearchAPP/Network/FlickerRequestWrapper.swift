//
//  FlickerRequestWrapper.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
class FlickerRequestWrapper {
    static func getBody(service :FlickerAPIManger) -> [String:Any] {
        switch service {
        case .getImages(let query,let page):
            return  ["method": APIConstant.SEARCH_METHOD, "api_key": APIConstant.flickerApiKey, "tags":query, "format":"json", "nojsoncallback": 1 ,"per_page" :20,"page":page]
        case .getGroups(let query):
            return  ["method": APIConstant.SEARCH_METHOD, "api_key": APIConstant.flickerApiKey, "tags":query, "format":"json", "nojsoncallback": 1 ,"per_page" :20,"page":1]
        }
    }
}
