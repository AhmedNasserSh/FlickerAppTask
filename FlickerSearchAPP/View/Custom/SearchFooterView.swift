//
//  SearchFooterView.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/21/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import KVNProgress
class SearchFooterView: UICollectionReusableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
  
    func show(_ show:Bool){
        if show {
            KVNProgress.show(withStatus: "", on: self)
        }else{
            KVNProgress.dismiss()
        }
    }

}
