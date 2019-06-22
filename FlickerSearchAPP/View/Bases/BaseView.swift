//
//  BaseView.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/20/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
@objc protocol BaseView {
    func startLoading()
    func finishLoading()
    @objc func errorMessage(error: String?)
}
