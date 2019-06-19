//
//  SearchItem.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
enum PhotoState {
    case new, downloaded, failed
}
class PhotoSearchItem :BaseModel  {
    var photos : PhotoResponse?
    override func mapping(map: Map) {
        super.mapping(map: map)
        photos <- map["photos"]
    }
}
class PhotoResponse :Mappable {
    var page : Int?
    var pages : Int?
    var perpage : Int?
    var photo : [Photo]?
    required init?(map: Map) { }
    func mapping(map: Map) {
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        photo <- map["photo"]
    }
}
class Photo : Mappable {
    var farm : Int?
    var id : String?
    var server : String?
    var secret : String?
    var image :UIImage?
    var state :PhotoState?
    required init?(map: Map) { }
    func mapping(map: Map) {
        farm <- map["farm"]
        id <- map["id"]
        server <- map["server"]
        secret <- map["secret"]
    }

    func getImageURL(_ size:String = "m") -> URL? {
        guard let f = farm , let s = server ,let i = id ,let c = secret else{ return nil}
        if let url =  URL(string: "https://farm\(f).staticflickr.com/\(s)/\(i)_\(c)_\(size).jpg") {
            return url
        }
        return nil
    }
}
