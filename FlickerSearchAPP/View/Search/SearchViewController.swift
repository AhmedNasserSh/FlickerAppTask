//
//  SearchViewController.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 9/2/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class SearchViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmented: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorrVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
