//
//  ImageLayout.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import UIKit
class  ImageLayout :UICollectionViewFlowLayout {
    let contentPadding :CGFloat = 10
    let cellsPadding :CGFloat = 7
    var contentSize: CGSize = .zero
    var cache = [UICollectionViewLayoutAttributes]()
    let numberOfcells: Int = 4
    let numberOfRows: Int = 5
    let numberOfColumns: Int = 2
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func prepare() {
        super.prepare()
        LoggerRepo.logInfo("ImageLayout:prepare")
        LoggerRepo.logDebug("ImageLayout:prepare,Parmters:()")
        guard let contentCollectionView = collectionView else {
            return
        }
        cache.removeAll()
        contentSize.width = contentCollectionView.frame.size.width
        var yOffset: CGFloat = 8
        let sectionsCount = contentCollectionView.numberOfSections
  
        for section in 0..<sectionsCount {
            let itemsCount = contentCollectionView.numberOfItems(inSection: section)
            
            for item in 0 ..< itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let smallCellHeight: CGFloat = (contentCollectionView.frame.height - 2 * contentPadding - cellsPadding) / CGFloat(numberOfRows)
                let largeCellHeight: CGFloat = smallCellHeight * 2 + cellsPadding
                let cellWidth = (contentCollectionView.frame.width - 2 * contentPadding - cellsPadding) / 2
                let addCellHeight = (contentCollectionView.frame.height - 2 * contentPadding - cellsPadding) / CGFloat(numberOfRows - 1)
                let addCellWidth = contentCollectionView.frame.width - 2 * contentPadding
                
                if indexPath.row % numberOfcells == 0 {
                    attributes.frame = CGRect(x: contentPadding, y: yOffset, width: cellWidth, height: smallCellHeight)
                    yOffset = (indexPath.row + 1 == itemsCount) ? yOffset + smallCellHeight : yOffset
                    yOffset += cellsPadding
                } else if indexPath.row % numberOfcells == 1 {
                    yOffset -= cellsPadding
                    attributes.frame = CGRect(x: cellWidth + contentPadding + cellsPadding, y: yOffset, width: cellWidth, height: largeCellHeight)
                    yOffset = (indexPath.row + 1 == itemsCount) ? yOffset + largeCellHeight : yOffset + smallCellHeight
                    yOffset += cellsPadding
                } else if indexPath.row % numberOfcells == 2 {
                    attributes.frame = CGRect(x: contentPadding, y: yOffset, width: cellWidth, height: smallCellHeight)
                    yOffset += smallCellHeight + cellsPadding
                } else if indexPath.row % numberOfcells == 3 {
                    attributes.frame = CGRect(x: contentPadding, y: yOffset, width: addCellWidth, height: addCellHeight)
                    yOffset += addCellHeight + cellsPadding
                }
                self.cache.append(attributes)
                
            }
        }
        contentSize.height = yOffset + 18
        // adding the footer attributes
        if let footerAttr =  layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 1, section: 0)) {
            footerAttr.frame = CGRect(x: 0, y:  contentSize.height - 40, width: collectionView?.frame.width ?? 100, height: 60)
            cache.append(footerAttr)
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        LoggerRepo.logInfo("ImageLayout:layoutAttributesForElements")
        LoggerRepo.logDebug("ImageLayout:layoutAttributesForElements,Parmters:(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?")
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        LoggerRepo.logInfo("ImageLayout:layoutAttributesForItem")
        LoggerRepo.logDebug("ImageLayout:layoutAttributesForItem,Parmters:(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?")
        return cache[indexPath.item]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        LoggerRepo.logInfo("ImageLayout:layoutAttributesForSupplementaryView")
        LoggerRepo.logDebug("ImageLayout:layoutAttributesForSupplementaryView,Parmters:(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? ")
        return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }

}
