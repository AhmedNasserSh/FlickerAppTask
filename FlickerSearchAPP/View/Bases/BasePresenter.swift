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
        LoggerRepo.logInfo("BasePresenter<T>:attachView")
        LoggerRepo.logDebug("BasePresenter<T>:attachView,Parmters:()")
    }
    func deattachView(){
        self.view = nil
        LoggerRepo.logInfo("BasePresenter<T>:deattachView")
        LoggerRepo.logDebug("BasePresenter<T>:deattachView,Parmters:()")
    }
}

