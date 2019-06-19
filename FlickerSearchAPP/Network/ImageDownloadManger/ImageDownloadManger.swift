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
                let task =  self.session.downloadTask(with: url) { (location, response, error) in
                    if let locationUrl = location, let data = try? Data(contentsOf: locationUrl){
                        let image = UIImage(data: data)
                        self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                        observer.onNext(image!)
                    }else if let e = error{
                        observer.onError(e)
                    }
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
            return Disposables.create()
        }
        return observer
    }
}
