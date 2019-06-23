//
//  Constant.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
enum SearchMethod :String{
    case images = "flickr.photos.search"
    case groups = "flickr.groups.search"
}
struct APIConstant {
    static let flickerApiKey = "6fb8eb6e7331133862bdb6083293bffb"
    static let production = "https://api.flickr.com/services/rest/"
    static let baseURL = production
}

