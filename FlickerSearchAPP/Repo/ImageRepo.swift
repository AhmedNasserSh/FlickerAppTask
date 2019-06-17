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
class ImageRepo {
    static let disposeBag = DisposeBag()
    static func getImagesByQuery(query:String,completion:@escaping apiCompleation) {
        print(url(route: FlickerAPIService.getImages(query: query, page: 1)))
        moyaProvider
            .rx
            .request(.getImages(query: query, page: 1))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (json) in
                if let images = Mapper<PhotoSearchItem>().map(JSONObject: json) {
                    completion(true,images)
                }
            }) { (error) in
                print(error)
            }.disposed(by: disposeBag)
    }
}

