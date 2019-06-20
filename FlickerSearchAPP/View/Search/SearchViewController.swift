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
class SearchViewController: BaseViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var page = 1
    var query = ""
    let presenter = SearchPresenter()
    let photos:BehaviorRelay<[Photo]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
}
// Mark : Controller Life Cycle
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setUpCollectionView()
        configureSearchBar()
    }
}
// Mark : Views Functions
extension SearchViewController {
    func setUpCollectionView() {
        photos.asObservable()
            .bind(to: self
                .imageCollectionView
                .rx
                .items(cellIdentifier: "PhotoCollectionViewCell", cellType: PhotoCollectionViewCell.self))  { row, data, cell in
            }.disposed(by: disposeBag)
        imageCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    func configureSearchBar() {
        searchBar
        .rx
        .searchButtonClicked
        .subscribe(onNext: { [unowned self]() in
            if let text = self.searchBar.text , text.count  > 0 {
                self.query = text
                self.presenter.searchPhoto(query:text, page: self.page)
            }
        }).disposed(by: disposeBag)

        searchBar
            .rx
            .textDidBeginEditing
            .subscribe(onNext: { [unowned self] in
                self.page = 0
                self.searchBar.setShowsCancelButton(true, animated: true)
            }).disposed(by: disposeBag)
        
        searchBar
        .rx
        .cancelButtonClicked
        .subscribe(onNext: { [unowned self] in
            self.searchBar.text = ""
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.searchBar.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    
}
// Mark :Collection View Delegate
extension SearchViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Lazy Loading images
        self.presenter.loadImageFrom(photo: photos.value[indexPath.row], indexPath: indexPath)
        
        // Load more Images
        if indexPath.row == photos.value.count - 2 {
            page += 1
            self.presenter.searchPhoto(query: query, page: page )
        }
    }
}
// Mark : SearchView Delegate
extension SearchViewController :SearchView {
    func setPhotos(photos: [Photo]) {
        self.photos.accept(self.photos.value + photos)
    }
    func setImage(image: UIImage, indexPath: IndexPath) {
        if let cell = imageCollectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell{
            cell.configure(image: image)
        }
    }
}
