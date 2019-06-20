//
//  SearchPresenter.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
protocol SearchView:BaseView {
    func setPhotos(photos:[Photo])
    func setImage(image:UIImage,indexPath:IndexPath)
}
class SearchPresenter:BasePresenter<SearchView> {
    let imageRepo =  ImageRepo()
    // Mark : Search Iamges
    func searchPhoto(query:String) {
        self.view?.startLoading()
        SearchRepo.getImagesByQuery(query: query) { (success, model) in
            self.view?.finishLoading()
            if success {
                guard let searchItem = (model as? SearchItem) ,let response = searchItem.response , let images = response.photos else{
                    self.view?.error(error: nil)
                    return
                }
                self.view?.setPhotos(photos: images)
            }else{
                self.view?.error(error: nil)
            }
        }
    }
    // Mark : Search Groups
    func searchGroup(query:String) {
        self.view?.startLoading()
        SearchRepo.getGroupsByQuery(query: query) { (success, model) in
            self.view?.finishLoading()
            if success {
                guard let searchItem = (model as? SearchItem) ,let response = searchItem.response , let images = response.groups else{
                    self.view?.error(error: nil)
                    return
                }
            }else{
                self.view?.error(error: nil)
            }
        }
    }
    
    func loadImageFrom(photo:Photo,indexPath:IndexPath) {
        imageRepo.getImageFrom(photo: photo) { (image) in
            self.view?.setImage(image: image, indexPath: indexPath)
        }
    }
}
