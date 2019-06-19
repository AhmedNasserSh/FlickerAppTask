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
    func getImageFrom(photo:Photo,completion :@escaping (UIImage) -> ()) {
        downloadManger.getImageTask(photo: photo)?
        .subscribeOn(downloadManger.backgroundWorkScheduler)
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .retry(2)
            .subscribe(onNext: { (image) in
                completion(image)
                print(image)
            }, onError: { (error) in
                print("e")
            }, onCompleted: {
                print("c")
            }, onDisposed: {
                print("d")
            }).disposed(by: bag)
    }
}
