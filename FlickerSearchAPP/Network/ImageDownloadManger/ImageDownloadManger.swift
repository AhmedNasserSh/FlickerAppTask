//
//  ImageDownloadManger.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/18/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import Moya
import RxSwift
class ImageDownloadManger {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    lazy var backgroundWorkScheduler
        = OperationQueueScheduler(operationQueue: downloadQueue)
    let imageCache = NSCache<NSString, UIImage>()
    var bag = DisposeBag()
    let session = URLSession.shared
}
// Mark : Downloader
extension ImageDownloadManger {
    func getImageTask(photo :Photo) -> Observable<UIImage>?  {
        let observer =  Observable<UIImage>.create { (observer) -> Disposable in
            // image not found 
            guard let url = photo.getImageURL()  else{
                observer.onError(NSError(domain: "", code: 404, userInfo: nil))
                return Disposables.create()
            }
            //check for image in cache
            if let cachedImage = self.imageCache.object(forKey: url.absoluteString as NSString) {
                print(":cach")
                observer.onNext(cachedImage)
            }else{
                // download the image
                    moyaProvider
                    .rx
                    .request(.downloadImage(url: url))
                    .mapImage()
                    .subscribe(onSuccess: { (image) in
                        self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                        observer.onNext(image!)
                    }, onError: { (error) in
                        observer.onError(error)
                    }).disposed(by: self.bag)
            }
            return Disposables.create()
        }
        return observer
    }
}
