//
//  ViewController.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/16/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ImageRepo.getImagesByQuery(query: "grass"){ (success,model) in
            print(model)
            
        }
    }


}

