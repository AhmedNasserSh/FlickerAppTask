//
//  FlickerSearchAppBusiness.swift
//  FlickerSearchAPPTests
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import XCTest
@testable import FlickerSearchAPP

class FlickerSearchAppBusiness: XCTestCase {
    var searchVC:SearchViewController?
    override func setUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        searchVC = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        _ = searchVC?.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadImages() {
        searchVC?.presenter.performQuery(cellItems: [], query: "grass", page: 1, type: .image)
        let pred = NSPredicate(format: "%@ != nil", searchVC?.searchItems.value ?? [])
        let exp = expectation(for: pred, evaluatedWith: searchVC as Any, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssert(searchVC?.searchItems.value.count ?? 0 > 0, "Image Api dosen't work properly")
        }
    }
    
    func testLoadGroups() {
        searchVC?.presenter.performQuery(cellItems: [], query: "grass", page: 1, type: .group)
        let pred = NSPredicate(format: "%@ != nil", searchVC?.searchItems.value ?? [])
        let exp = expectation(for: pred, evaluatedWith: searchVC as Any, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 8.0)
        if res == XCTWaiter.Result.completed {
            XCTAssert(searchVC?.searchItems.value.count ?? 0 > 0, "Image Api dosen't work properly")
        }
    }
    
    func testPrepareGroup() {
        let searchItem = MockRepo<SearchItem>().generateMockup(resourcePath: "Groups")
        XCTAssertNotNil(searchItem?.groups, "Mockup group dosen't generate")
        searchVC?.presenter.prepareGroups(searchItem: (searchItem?.groups)!)
        let cellModel = searchVC?.searchItems.value
        XCTAssertNotNil(cellModel, "prepare group faild to set data")
        let firstItem = cellModel?[0].items[0] as? Group
        XCTAssert(firstItem?.members?.contains("k") ?? false, "Change values to k faild")
    }
 
    func testLoadMore() {
        searchVC?.currentType  = .group
        let searchItem = MockRepo<SearchItem>().generateMockup(resourcePath: "Groups")
        XCTAssertNotNil(searchItem?.groups, "Mockup group dosen't generate")
        searchVC?.presenter.prepareGroups(searchItem: (searchItem?.groups)!)
        let cellModel = [CellSectionModel(header: "", items: (searchItem?.groups)!)]
        searchVC?.presenter.loadMore(indexPath: IndexPath(row: 16, section: 0), cellItems: cellModel, query: "grass", page: 1, type: .group)
        let pred = NSPredicate(format: "%@ != nil", searchVC?.searchItems.value ?? [])
        let exp = expectation(for: pred, evaluatedWith: searchVC as Any, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssert(searchVC?.searchItems.value[0].items.count ?? 0 > 20, "load more  dosen't work properly")
        }

    }
    
}
