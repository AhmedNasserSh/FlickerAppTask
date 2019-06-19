//
//  ViewController.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/16/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var im: UIImageView!
    
    @IBOutlet weak var ImagesCollectionView: UICollectionView!
    @IBOutlet weak var id: UIImageView!
    let d = ImageDownloadManger()
    override func viewDidLoad() {
        super.viewDidLoad()
//        ImageRepo.getImagesByQuery(query: "grass"){ (success,model) in
//            print(model)
//
//        }
//        d.getImageTask(url: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260") { (image) in
//            self.imageView.image = image
//        }
//        d.getImageTask(url: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260") { (image) in
//            self.im.image = image
//        }
//
//        d.getImageTask(url: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260") { (image) in
//            self.id.image = image
//        }
    }


}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        d.getImageTask(url: "https://farm66.staticflickr.com/65535/48085205553_26cd9a692e_m.jpg") { (image) in
            (cell as! PhotoCollectionViewCell).imageView.image = image
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
}
