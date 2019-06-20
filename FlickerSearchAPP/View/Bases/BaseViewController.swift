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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension BaseViewController :BaseView {
    func startLoading() {
        KVNProgress.show()
    }
    
    func finishLoading() {
        KVNProgress.dismiss()
    }
    
    func error(error: ErrorModel?) {
    }
    
    func message(message: String) {
    }
    
    
}
