//
//  SearchViewController.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
class SearchViewController: BaseViewController {
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var footerView :SearchFooterView?
    let searchItems:BehaviorRelay<[CellSectionModel]> = BehaviorRelay(value: [])
    let presenter = SearchPresenter()
    let disposeBag = DisposeBag()
    var page = 1
    var query = "Nature"
    var currentType:SearchViewType = .image
}
// Mark : Controller Life Cycle
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        registerFooterCell()
        configureCollectionViewDataSource()
        configureCollectionViewDelegate()
        configureSearchBar()
        searchBarDidBeginEditing()
        searchBarCancelButton()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        setupFilterSegmentedContol()
    }
}
// Mark : filter Segmented Control
extension SearchViewController {
    func setupFilterSegmentedContol(){
        filterSegmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [unowned self] index in
                self.currentType = index == 0 ? .image :.group
                // reset
                self.reset(searchQuery: self.query)
                self.setCollectionViewLayout()
            }).disposed(by: disposeBag)
    }
}
// Mark: Configure Search bar
extension SearchViewController {
    func configureSearchBar() {
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [unowned self]() in
                if let text = self.searchBar.text , text.count  > 0 {
                  self.reset(searchQuery: text)
                }
            }).disposed(by: disposeBag)
    }
    
    func searchBarDidBeginEditing(){
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                self.page = 1
                self.searchBar.setShowsCancelButton(true, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func searchBarCancelButton(){
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [unowned self] in
                self.searchBar.text = ""
                self.searchBar.setShowsCancelButton(false, animated: true)
                self.searchBar.endEditing(true)
            }).disposed(by: disposeBag)
    }
}
// Mark : SearchView Delegate
extension SearchViewController :SearchView {
    func reset(searchQuery:String){
        self.searchItems.accept([])
        self.query = searchQuery
        self.useProgress = true
        search(query: query, page: 1)
    }
    func search(query:String,page:Int) {
        self.presenter.performQuery(query: query, page: page, type: currentType)
    }
    func setItem(searchItem:[Mappable]) {
        let currentPhotos = self.searchItems.value.count > 0 ?  self.searchItems.value[0].items : []
        self.searchItems.accept([CellSectionModel(header:"", items:currentPhotos + searchItem)])
    }
    
    func setImage(image: UIImage, indexPath: IndexPath) {
        if let cell = imageCollectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell {
            cell.loadImage(image)
            
        }
    }
}
