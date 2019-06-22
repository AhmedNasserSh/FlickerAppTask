//
//  BaseRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation

import ObjectMapper
typealias ApiHandler =  (_ success: Bool, _ dataModel: BaseModel?) -> Void
class BaseRepo<T> where T:BaseModel {
    static func handleResult(_ json:Any?,completion:ApiHandler) {
        LoggerRepo.logInfo("BaseRepo:handleResult")
        LoggerRepo.logDebug("BaseRepo:handleResult ,Parmters:(_ json:Any?,completion:ApiHandler)")
        let model = Mapper<T>().map(JSONObject: json)
        if model?.statCode == nil {
            completion(true,model)
        }else{
            print(model?.message ?? "Unknown Error")
        }
    }
}

