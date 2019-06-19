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
    func getImageTask(url :String,completion :@escaping (UIImage) -> ())  {
        let observer =  Observable<UIImage>.create { (observer) -> Disposable in
            let session = URLSession.shared
           // guard let url = photo.getImageURL()  else{return}
            if let cachedImage = self.imageCache.object(forKey: url as NSString) {
                observer.onNext(cachedImage)
            }else{
                let task =  session.downloadTask(with: URL(string: url)!) { (location, response, error) in
                    if let locationUrl = location, let data = try? Data(contentsOf: locationUrl){
                        let image = UIImage(data: data)
                        self.imageCache.setObject(image!, forKey: url as NSString)
                        observer.onNext(image!)
                        // self.downloadHandler?(image,self.imageUrl, self.indexPath,error)
                    }else if let e = error{
                        observer.onError(e)
                    }
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
            return Disposables.create { }
        }
        observer.subscribeOn(backgroundWorkScheduler)
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .retry(1)
            .subscribe(onNext: { (image) in
                completion(image)
                print(image)
            }, onError: { (error) in
                print("e")
            }, onCompleted: {
                print("c")
            }, onDisposed: {
                print("d")
            })
    }
}
