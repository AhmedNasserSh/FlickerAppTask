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
    static func searchPhoto(query:String,page:Int,api:@escaping ApiHandler) {
        moyaProvider.rx.request(.getImages(query: query, page: page))
            .mapJSON()
            .subscribe(onSuccess: { (response) in
            self.handleResult(response, completion: api)
        }) { (error) in
            
        }.disposed(by: disposeBag)
    }
}
