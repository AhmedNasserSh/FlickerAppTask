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
import RxDataSources
import ObjectMapper
class SearchViewController: BaseViewController {
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var footerView :SearchFooterView?
    let photos:BehaviorRelay<[CellSectionModel]> = BehaviorRelay(value: [])
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
            }).disposed(by: disposeBag)
    }
}
// Mark : collectionView
extension SearchViewController {
    func registerFooterCell() {
        let nib = UINib(nibName: "SearchFooterView", bundle: nil)
        imageCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchFooterView")
    }
    
    func configureCollectionViewDataSource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<CellSectionModel>(configureCell: { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
            cell.reset()
            return cell
        })
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            self.footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchFooterView", for: indexPath) as? SearchFooterView
            return self.footerView!
        }
        photos.bind(to: imageCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    func configureCollectionViewDelegate() {
        imageCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        imageCollectionView.rx.willDisplaySupplementaryView
            .subscribe({ [unowned self] _  in
                self.footerView?.configure()
            }).disposed(by: disposeBag)
        imageCollectionView.rx.didEndDisplayingSupplementaryView
            .subscribe({ [unowned self] _  in
                self.footerView?.dismiss()
            }).disposed(by: disposeBag)
    }
}
// Mark :Collection View Delegate
extension SearchViewController :UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Lazy Loading images
        self.presenter.loadImageFrom(searchItem: photos.value[0].items, indexPath: indexPath, type: currentType)
        // Load more Images
        loadMore(indexPath: indexPath)
    }

    func loadMore(indexPath: IndexPath) {
        if indexPath.row == photos.value[0].items.count - 4 {
            page += 1
            useProgress = false
            self.presenter.searchPhoto(query: query, page: page )
        }
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
        self.photos.accept([])
        self.query = searchQuery
        self.useProgress = true
        search(query: query, page: 1)
    }
    func search(query:String,page:Int) {
        self.presenter.performQuery(query: query, page: page, type: currentType)
    }
    func setItem(searchItem:[Mappable]) {
        let currentPhotos = self.photos.value.count > 0 ?  self.photos.value[0].items : []
        self.photos.accept([CellSectionModel(header:"", items:currentPhotos + searchItem)])
    }
    
    func setImage(image: UIImage, indexPath: IndexPath) {
        if let cell = imageCollectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell{
            cell.configure(image: image)
        }
    }
}
