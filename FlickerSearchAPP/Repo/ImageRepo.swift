//
//  ImageRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/19/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import RxSwift
class ImageRepo {
    let downloadManger = ImageDownloadManger()
    let bag = DisposeBag()
    func getImageFrom(url:URL,completion :@escaping (UIImage) -> ()) {
        LoggerRepo.logInfo("ImageRepo:getImageFrom")
        LoggerRepo.logDebug("ImageRepo:getImageFrom ,Parmters:(url:URL,completion :@escaping (UIImage) -> ())")
        downloadManger.getImageTask(url: url)?
        .subscribeOn(downloadManger.backgroundWorkScheduler)
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .retry(2)
            .subscribe(onNext: { (image) in
                completion(image)
                LoggerRepo.logDebug("ImageRepo:getImageFrom ,response:\(image)")
            }, onError: { (error) in
                LoggerRepo.logWarn("ImageRepo:getImageFrom ,Error:\(error)")
            }).disposed(by: bag)
    }
}
