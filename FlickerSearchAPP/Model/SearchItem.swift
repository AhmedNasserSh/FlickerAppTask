//
//  SearchItem.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class FlickerResponse :BaseModel  {
    var response : SearchItem?
    var groupResponse : SearchItem?
    override func mapping(map: Map) {
        super.mapping(map: map)
        response <- map["photos"]
        groupResponse <- map["groups"]
    }
}
class SearchItem :Mappable {
    var page : Int?
    var pages : Int?
    var perpage : Int?
    var photos : [Photo]?
    var groups :[Group]?
    
    init() {}
    required init?(map: Map) { }

    func mapping(map: Map) {
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        photos <- map["photo"]
        groups <- map["group"]
    }
}
