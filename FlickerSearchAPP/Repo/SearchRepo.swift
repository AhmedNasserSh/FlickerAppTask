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
class SearchRepo :BaseRepo<SearchItem>{
    static let disposeBag = DisposeBag()
    
    // Mark : search Image
    static func getImagesByQuery(query:String,page:Int,completion:@escaping ApiHandler) {
        moyaProvider
            .rx
            .request(.getImages(query: query, page: page))
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                print(json)
                self.handleResult(json, completion: completion)
            }) { (error) in completion(false,nil)}
            .disposed(by: disposeBag)
    }
    
    // Mark : search Groups
    static func getGroupsByQuery(query :String,completion:@escaping ApiHandler) {
        moyaProvider
        .rx
        .request(.getGroups(query: query))
        .mapJSON()
            .subscribe(onSuccess: { (json) in
                print(json)
            }){ (error) in completion(false,nil)}
        .disposed(by: disposeBag)
    }
}
