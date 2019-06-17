//
//  Constant.swift
//  CodeBase
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import Foundation

struct APIConstant {
    static let flickerApiKey = "6fb8eb6e7331133862bdb6083293bffb"
    static let production = "https://api.flickr.com/services/rest/"
    static let SEARCH_METHOD:String = "flickr.photos.search"
    static let staging = ""
    static let baseURL = production
}

struct ErrorMessage {
    static let unknownAPIError = "Service is currently unavailable."
    static let unavailableData = "Data is currently unavailable"
    static let unauthenticatedError = "Your session has expired. Please re-login."
}
