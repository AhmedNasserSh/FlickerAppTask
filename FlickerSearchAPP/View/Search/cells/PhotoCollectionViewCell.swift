//
//  PhotoCollectionViewCell.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/19/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import Kingfisher
class PhotoCollectionViewCell: BaseCollectionViewCell {
    func setPhoto(_ photo:Photo) {
        imageView.kf.setImage(with: photo.getImageURL(), placeholder: UIImage(named: "no_image"))
    }
}
