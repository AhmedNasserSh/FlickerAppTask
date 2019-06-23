//
//  PhotoCollectionViewCell.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/19/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: BaseCollectionViewCell {
    func reset() {
        LoggerRepo.logInfo("PhotoCollectionViewCell:reset")
        LoggerRepo.logDebug("PhotoCollectionViewCell:reset,Parmters:()")
        self.imageView.image = #imageLiteral(resourceName: "no_image")
    }
}
