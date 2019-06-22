//
//  BaseViewController.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import KVNProgress
class BaseViewController: UIViewController {
    var useProgress = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension BaseViewController :BaseView {
    func errorMessage(error: String?) {
        LoggerRepo.logInfo("BaseViewController:errorMessage")
        LoggerRepo.logDebug("BaseViewController:errorMessage,Parmters:()")
        LoggerRepo.logWarn("BaseViewController:errorMessage,Error:\(String(describing: error))")
    }
    func startLoading() {
        LoggerRepo.logInfo("BaseViewController:startLoading")
        LoggerRepo.logDebug("BaseViewController:startLoading,Parmters:()")
        if useProgress {
            KVNProgress.show()
        }
    }
    func finishLoading() {
        LoggerRepo.logInfo("BaseViewController:finishLoading")
        LoggerRepo.logDebug("BaseViewController:finishLoading,Parmters:()")
        KVNProgress.dismiss()
    }
}
