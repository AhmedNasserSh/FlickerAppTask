//
//  MainPresenter.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
class  MainPresenter :BasePresenter<BaseView> {
    let imageRepo =  ImageRepo()
    func loadImageFromUrl (photo:Photo) {
        imageRepo.getImageFrom(photo: photo) { (image) in
            
        }
    }
}
