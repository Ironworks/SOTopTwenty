//
//  MainViewControllerTest.swift
//  SOTopTwenty_iOSTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwenty_iOS
@testable import SOTopTwentyKit

import XCTest

class MainViewControllerTest: XCTestCase {
    
    var sut: MainViewController!
    var mockImageClient: MockImageService!
    var mockViewModel: MockMainViewModel!

    override func setUp() {
        super.setUp()
        mockViewModel = MockMainViewModel(service: StackOverflowClient.shared)
        sut = MainViewController(viewModel: mockViewModel)
        mockImageClient = MockImageService()
        sut.imageClient = mockImageClient
        
    }

    override func tearDown() {
        sut = nil
        mockImageClient = nil 
        super.tearDown()
    }
    
    func testInitSetsViewModel() {
        XCTAssertTrue(sut.viewModel === mockViewModel)
    }
    
    func testViewModelConformsToMainViewModelProtocol() {
        XCTAssertTrue((sut.viewModel as AnyObject) is MainViewModelProtocol)
    }
    
    func testOnViewDidAppearViewModelRetrieveUsersIsCalled() {
        sut.viewDidAppear(false)
        XCTAssertTrue(mockViewModel.retrieveUsersCalled)
    }
    
    func testImageClientIsImageService() {
        XCTAssertTrue((sut.imageClient as AnyObject) is ImageService)
    }
    
    func testImageClientSetToSharedImageClient() {
        let expected = ImageClient.shared
        let viewModel = MainViewModel(service: StackOverflowClient.shared)
        sut = MainViewController(viewModel: viewModel)
        
        XCTAssertTrue(sut.imageClient as? ImageClient === expected)
    }
}
