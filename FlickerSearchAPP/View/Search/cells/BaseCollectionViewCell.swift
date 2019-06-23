//
//  BaseCollectionViewCell.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func loadImage(_ image:UIImage) {
        LoggerRepo.logInfo("BaseCollectionViewCell:loadImage")
        LoggerRepo.logDebug("BaseCollectionViewCell:loadImage,Parmters:(_ image:UIImage)")
        self.imageView.image = image
    }
}
