//
//  ImageDownloadOperation.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/18/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
class ImageDownloadOperation {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
}
class ImageDownloader: Operation {
    let photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    override func main() {
        if isCancelled {return}
        guard let url = photo.getImageURL() , let imageData = try? Data(contentsOf: url) else { return }
        if isCancelled {return}
        if !imageData.isEmpty {
            photo.image = UIImage(data:imageData)
            photo.state = .downloaded
        } else {
            photo.state = .failed
            photo.image = UIImage(named: "Failed")
        }
    }
    func downloadImage() {
//        let session = URLSession.shared
//        guard let url = photo.getImageURL()  else{return}
//        let downloadTask = session.downloadTask(with: url) { (location, response, error) in
//            if let locationUrl = location, let data = try? Data(contentsOf: locationUrl){
//                let image = UIImage(data: data)
//                self.downloadHandler?(image,self.imageUrl, self.indexPath,error)
//            }
//            self.finish(true)
//            self.executing(false)
//        }
//        downloadTask.resume()
    }

}
