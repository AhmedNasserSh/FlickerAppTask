//
//  PhotoCollectionViewCell.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/19/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func reset() {
        self.imageView.image = #imageLiteral(resourceName: "no_image")
    }
    
    func configure(image:UIImage) {
        self.imageView.image = image
    }
}
