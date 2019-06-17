//
//  BaseRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation

import ObjectMapper
typealias ApiHandler =  (_ success: Bool, _ dataModel: Mappable?) -> Void
class BaseRepo<T> where T:BaseModel {
    static func handleResult(_ json:Any?,completion:ApiHandler) {
        let model = Mapper<T>().map(JSONObject: json)
        var error = 0
        switch model?.statCode {
        case nil:
            error = 0
            break
        default: break
        }
        if error == 0 {
            completion(true,model)
        }else{
            
        }
    }
    func error(_ ecode:Int) ->String {
        if ecode == 401 {
            return "Not Authorized"
        }
        return "Ops"
    }
}

