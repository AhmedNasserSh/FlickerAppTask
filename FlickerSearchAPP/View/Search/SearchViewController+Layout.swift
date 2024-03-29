//
//  SearchViewController+Layout.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources
// Mark : collectionView Delegate and Datasource
extension SearchViewController {
    func registerFooterCell() {
        LoggerRepo.logInfo("SearchViewController:registerFooterCell")
        LoggerRepo.logDebug("SearchViewController:registerFooterCell,Parmters:()")
        let nib = UINib(nibName: "SearchFooterView", bundle: nil)
        imageCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchFooterView")
    }
    
    func configureCollectionViewDataSource() {
        LoggerRepo.logInfo("SearchViewController:configureCollectionViewDataSource")
        LoggerRepo.logDebug("SearchViewController:configureCollectionViewDataSource,Parmters:()")
        let dataSource = RxCollectionViewSectionedReloadDataSource<CellSectionModel>(configureCell: { dataSource, collectionView, indexPath, item in
            return self.configureCellForIndexPath(indexPath: indexPath)
        })
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            self.footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchFooterView", for: indexPath) as? SearchFooterView
            return self.footerView!
        }
        searchItems.bind(to: imageCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    func configureCollectionViewDelegate() {
        LoggerRepo.logInfo("SearchViewController:configureCollectionViewDelegate")
        LoggerRepo.logDebug("SearchViewController:configureCollectionViewDelegate,Parmters:()")
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
        LoggerRepo.logInfo("SearchViewController:collectionView")
        LoggerRepo.logDebug("SearchViewController:collectionView,Parmters:(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int)")
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        LoggerRepo.logInfo("SearchViewController:collectionView")
        LoggerRepo.logDebug("SearchViewController:collectionView,Parmters:(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)")
        
        // Lazy Loading images
        self.presenter.loadImageFrom(searchItem: searchItems.value[0].items, indexPath: indexPath, type: currentType)
        // Load more Images
        self.presenter.loadMore(indexPath: indexPath, cellItems: self.searchItems.value, query: query, page: page, type: currentType)
    }
}
// Mark : CollectionView Layout 
extension SearchViewController {
    func setCollectionViewLayout() {
        LoggerRepo.logInfo("SearchViewController:setCollectionViewLayout")
        LoggerRepo.logDebug("SearchViewController:setCollectionViewLayout,Parmters:()")
        let layout :UICollectionViewFlowLayout?
        if currentType == .group {
            // group Layout
            layout = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0  , bottom: 0, right: 0  )
                layout.minimumLineSpacing = 10
                layout.itemSize = CGSize(width: self.view.frame.width - 20, height: 80)
                return layout
            }()
        }else{
            layout = {return ImageLayout()}()
        }
        imageCollectionView.setCollectionViewLayout(layout!, animated: true, completion: nil)
    }
    func configureCellForIndexPath (indexPath:IndexPath) -> UICollectionViewCell {
        LoggerRepo.logInfo("SearchViewController:configureCellForIndexPath")
        LoggerRepo.logDebug("SearchViewController:configureCellForIndexPath,Parmters:(indexPath:IndexPath) -> UICollectionViewCell")
        if currentType == .image {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
            cell.reset()
            return cell
        }
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as! GroupCollectionViewCell
        cell.configure(group: self.searchItems.value[0].items[indexPath.row] as! Group)
        return cell
    }
    
}
