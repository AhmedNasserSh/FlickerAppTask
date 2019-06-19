//
//  ImageRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
class ImageRepo :BaseRepo<PhotoSearchItem>{
    static let disposeBag = DisposeBag()
    
    static func getImagesByQuery(query:String,completion:@escaping ApiHandler) {
        moyaProvider
            .rx
            .request(.getImages(query: query, page: 1))
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                self.handleResult(json, completion: completion)
            }) { (error) in completion(false,nil)}
            .disposed(by: disposeBag)
    }
}
