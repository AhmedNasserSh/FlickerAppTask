//
//  SearchItem.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
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
    required init?(map: Map) { }
    func mapping(map: Map) {
        farm <- map["farm"]
        id <- map["id"]
        server <- map["server"]
        secret <- map["secret"]
    }

//    func flickrImageURL(_ size:String = "m") -> URL? {
//        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
//            return url
//        }
//        return nil
//    }
    
}
//
//func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
//    return lhs.photoID == rhs.photoID
//}
