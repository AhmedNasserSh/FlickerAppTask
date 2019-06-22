//
//  SearchPresenter.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
enum SearchViewType {
    case group
    case image
}
protocol SearchView:BaseView {
    func setItem(searchItem:[Mappable])
    func setImage(image:UIImage,indexPath:IndexPath)
}
class SearchPresenter:BasePresenter<SearchView> {
    let imageRepo =  ImageRepo()
    var currentType :SearchViewType = .image
    func performQuery(query:String,page:Int,type:SearchViewType) {
        currentType = type
        if type == .image {
            searchPhoto(query: query, page: page)
        }else{
            searchGroup(query: query, page: page)
        }
    }
    // Mark : Search Iamges
    func searchPhoto(query:String,page:Int) {
        self.view?.startLoading()
        SearchRepo.getImagesByQuery(query: query, page: page) { (success, model) in
            self.view?.finishLoading()
            if success {
                guard let response = (model as? FlickerResponse) ,let searchItem = response.response , let images = searchItem.photos  else{
                    self.view?.error(error: nil)
                    return
                }
                self.view?.setItem(searchItem: images)
            }else{
                self.view?.error(error: nil)
            }
        }
    }
    // Mark : Search Groups
    func searchGroup(query:String,page:Int) {
        self.view?.startLoading()
        SearchRepo.getGroupsByQuery(query: query, page: page) { (success, model) in
            self.view?.finishLoading()
            if success {
                 guard let response = (model as? FlickerResponse) ,let searchItem = response.groupResponse , let groups = searchItem.groups else{
                    self.view?.error(error: nil)
                    return
                }
                self.prepareGroups(searchItem: groups)
            }else{
                self.view?.error(error: nil)
            }
        }
    }
    func prepareGroups(searchItem:[Mappable]) {
       let groups = searchItem.map { (element) -> Mappable in
            if let group = element as? Group {
                let members = Float (group.members ?? "0") ?? 0
                let poolCount = Float (group.poolCount ?? "0") ?? 0
                group.members = members / 1000 >= 1  ?  members / 1000 < 1000 ?  "\(members / 1000) k" : "\(members / 1000000) m"  : group.members
                group.poolCount = poolCount / 1000 >= 1  ?  poolCount / 1000 < 1000 ?  "\(poolCount / 1000) k" : "\(poolCount / 1000000) m"  : group.poolCount
                return group
            }
            return element
        }
        self.view?.setItem(searchItem: groups)
    }

}
extension SearchPresenter {
    func loadImageFrom(searchItem: [Mappable],indexPath:IndexPath,type:SearchViewType) {
        let url = type == .image ? (searchItem[indexPath.row] as? Photo)?.getImageURL() :(searchItem[indexPath.row] as? Group)?.getGroupIconURL()
        if url != nil {
            imageRepo.getImageFrom(url: url!) { (image) in
                self.view?.setImage(image: image, indexPath: indexPath)
            }
        }else{
            // error in url
        }
    }
}
