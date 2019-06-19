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
    @IBOutlet weak var ImagesCollectionView: UICollectionView!
    let imageRepo =         ImageRepo()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        imageRepo.getImageFrom(photo: Photo() ) { (image) in
            (cell as! PhotoCollectionViewCell).imageView.image = image
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
}
