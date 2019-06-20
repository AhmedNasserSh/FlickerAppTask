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
    @IBOutlet weak var searchTextField: UITextField!
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
        configureSearch()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        imageCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureSearch() {
        searchTextField
        .rx
        .controlEvent(UIControlEvents.editingDidEnd)
        .subscribe(onNext: { [unowned self]() in
            if let text = self.searchTextField.text , text.count  > 0 {
                self.presenter.searchPhoto(query:text)
            }
        }).disposed(by: disposeBag)
    }
}
// Mark :Collection View Delegate
extension SearchViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Lazy Loading images
        self.presenter.loadImageFrom(photo: photos.value[indexPath.row], indexPath: indexPath)
    }
}
// Mark : SearchController Delegate
extension SearchViewController :UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
// Mark : SearchView Delegate
extension SearchViewController :SearchView {
    func setPhotos(photos: [Photo]) {
        self.photos.accept(photos)
    }
    func setImage(image: UIImage, indexPath: IndexPath) {
        if let cell = imageCollectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell{
            cell.configure(image: image)
        }
    }
}
