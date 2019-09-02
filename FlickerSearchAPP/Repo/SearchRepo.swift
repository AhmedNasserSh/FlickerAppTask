//
//  SearchRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
class SearchRepo :BaseRepo<FlickerResponse>{
    static let disposeBag = DisposeBag()
    
    // Mark : search Image
    static func getImagesByQuery(query:String,page:Int,completion:@escaping ApiHandler) {
        LoggerRepo.logInfo("SearchRepo:getImagesByQuery")
        LoggerRepo.logDebug("SearchRepo:getImagesByQuery ,Parmters:(query:String,page:Int,completion:@escaping ApiHandler)")
        moyaProvider
            .rx
            .request(.getImages(query: query, page: page))
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                self.handleResult(json, completion: completion)
            }) { (error) in
                completion(false,nil)
                LoggerRepo.logWarn("SearchRepo:getImagesByQuery ,Error:\(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // Mark : search Groups
    static func getGroupsByQuery(query :String,page:Int,completion:@escaping ApiHandler) {
        LoggerRepo.logInfo("SearchRepo:getGroupsByQuery")
        LoggerRepo.logDebug("SearchRepo:getGroupsByQuery ,Parmters:(query:String,page:Int,completion:@escaping ApiHandler)")
        moyaProvider
        .rx
        .request(.getGroups(query: query, page: page))
        .mapJSON()
            .subscribe(onSuccess: { (json) in
                LoggerRepo.logDebug("SearchRepo:getGroupsByQuery ,Response:\(json)")
                self.handleResult(json, completion: completion)
            }){ (error) in
                completion(false,nil)
                LoggerRepo.logWarn("SearchRepo:getGroupsByQuery ,Error:\(error)")
            }
        .disposed(by: disposeBag)
    }
}
