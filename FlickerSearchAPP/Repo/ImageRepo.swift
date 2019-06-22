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
        downloadManger.getImageTask(url: url)?
        .subscribeOn(downloadManger.backgroundWorkScheduler)
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .retry(2)
            .subscribe(onNext: { (image) in
                completion(image)
                print(image)
            }, onError: { (error) in
                print("e")
            }).disposed(by: bag)
    }
}
