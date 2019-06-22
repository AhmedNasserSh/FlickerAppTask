//
//  FlickerSearchAPPTests.swift
//  FlickerSearchAPPTests
//
//  Created by Ahmed Nasser on 6/16/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import XCTest
@testable import FlickerSearchAPP

class FlickerSearchAPPTests: XCTestCase {
    var searchVC:SearchViewController?
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        searchVC = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        _ = searchVC?.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(sb, "Main Storyboard dosen't exsit")
        let searchVC = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        XCTAssertNotNil(searchVC, "SearchViewController dosen't exsit")
    }
    func testImageCollectionLayout() {
        searchVC?.currentType = .image
        searchVC?.setCollectionViewLayout()
        XCTAssertNotNil(searchVC?.imageCollectionView, "SearchViewController image collectionView dosen't exsit")
        let layout = searchVC?.imageCollectionView.collectionViewLayout as? ImageLayout
        XCTAssertNotNil(layout, "Wrong Layout passed to Image Search type")
    }
    func testGroupCollectionLayout() {
        searchVC?.currentType = .group
        searchVC?.setCollectionViewLayout()
        XCTAssertNotNil(searchVC?.imageCollectionView, "SearchViewController image collectionView dosen't exsit")
        let layout = searchVC?.imageCollectionView.collectionViewLayout
        XCTAssertNotNil(layout, "Wrong Layout passed to Group Search type")
    }
    func testGroupCellForIndexPath() {
        searchVC?.currentType = .group
        let searchItem = MockRepo<SearchItem>().generateMockup(resourcePath: "Groups")
        XCTAssertNotNil(searchItem?.groups, "Mockup group dosen't generate")
        searchVC?.setItem(cellItems: [CellSectionModel(header: "", items: (searchItem?.groups)!)], page: 1)
        let cell = searchVC?.configureCellForIndexPath(indexPath: IndexPath(item: 0, section: 0)) as? GroupCollectionViewCell
        XCTAssertNotNil(cell, "Wrong Cell passed to Group Search type")
    }
    func testImageCellForIndexPath() {
        searchVC?.currentType = .image
        let searchItem = MockRepo<SearchItem>().generateMockup(resourcePath: "Photos")
        XCTAssertNotNil(searchItem?.photos, "Mockup Photo dosen't generate")
        searchVC?.setItem(cellItems: [CellSectionModel(header: "", items: (searchItem?.photos)!)], page: 1)
        let cell = searchVC?.configureCellForIndexPath(indexPath: IndexPath(item: 0, section: 0)) as? PhotoCollectionViewCell
        XCTAssertNotNil(cell, "Wrong Cell passed to Image Search type")
    }
    func testReset() {
        searchVC?.reset(searchQuery: "grass")
        XCTAssert(searchVC?.query == "grass" , "Reset is not working properly")
        XCTAssert(searchVC?.useProgress == true,  "Reset is not working properly")
    }


}
