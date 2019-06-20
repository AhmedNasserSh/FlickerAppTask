//
//  BasePresenter.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
class BasePresenter<T> {
    var view: T?
    func attachView(view: T) {
        self.view = view
    }
    func deattachView(){
        self.view = nil
    }
}

