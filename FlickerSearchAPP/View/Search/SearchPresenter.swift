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
    func setItem(cellItems:[CellSectionModel],page:Int)
    func setImage(image:UIImage,indexPath:IndexPath)
}
class SearchPresenter:BasePresenter<SearchView> {
    let imageRepo =  ImageRepo()
    var currentType :SearchViewType = .image
    var currentMappleItem :[Mappable]?
    var page = 0
    func performQuery(cellItems:[CellSectionModel],query:String,page:Int,type:SearchViewType) {
        self.currentMappleItem = cellItems.count > 0 ?  cellItems[0].items : []
        self.currentType = type
        self.page = page
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
                    self.view?.errorMessage(error: "No Images Available")
                    return
                }
                self.setItems(items: images)
            }else{
                self.view?.errorMessage(error: "No Images Available")
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
                    self.view?.errorMessage(error: "No Groups Available")
                    return
                }
                self.prepareGroups(searchItem: groups)
            }else{
                self.view?.errorMessage(error: "No Groups Available")
            }
        }
    }
    
}
// Mark : Hlper functions
extension SearchPresenter {
    // append current items to new items
    func setItems(items:[Mappable]) {
        let cellItems =  [CellSectionModel(header:"", items: (currentMappleItem ?? []) + items)]
        if cellItems[0].items.count > 0 {
            self.view?.setItem(cellItems: cellItems, page: page)
        }else{
            self.view?.errorMessage(error: currentType == .image ? "No Images Available":"No Groups Available")
        }
    }
    func loadImageFrom(searchItem: [Mappable],indexPath:IndexPath,type:SearchViewType) {
        let url = type == .image ? (searchItem[indexPath.row] as? Photo)?.getImageURL() :(searchItem[indexPath.row] as? Group)?.getGroupIconURL()
        if url != nil {
            imageRepo.getImageFrom(url: url!) { (image) in
                self.view?.setImage(image: image, indexPath: indexPath)
            }
        }else{
            // error in url
            self.view?.setImage(image: UIImage(named: "no_image")!, indexPath: indexPath)
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
        self.setItems(items: groups)
    }

    func loadMore(indexPath: IndexPath,cellItems:[CellSectionModel],query:String,page:Int,type:SearchViewType) {
        let currentItems = cellItems.count > 0 ?  cellItems[0].items : []
        if indexPath.row == currentItems.count - 4 {
            self.performQuery(cellItems: cellItems, query: query, page: page + 1, type: type)
        }
    }
}
