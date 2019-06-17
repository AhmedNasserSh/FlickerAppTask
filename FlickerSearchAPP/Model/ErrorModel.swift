//
//  ErrorModel.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class ErrorModel :Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    var eCode: Int?
    var eMsg: String?
    init(eCode: Int?,eMsg: String?) {
        self.eCode = eCode
        self.eMsg = eMsg
    }
}
