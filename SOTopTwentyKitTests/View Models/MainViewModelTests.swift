//
//  MainViewModelTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
import XCTest

class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var service: MockStackOverflowClient!
    var mockViewController: MockViewController!
    var error: Error!

    override func setUp() {
        super.setUp()
        service = MockStackOverflowClient()
        sut = MainViewModel(service: service)
    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
    
    func givenUsers(count: Int = 3) -> Items {
        let users: [User]  = (1...count).map { i in
            let user = User(profileImage: "http://example.com/\(i)",
                userName: "name\(i)",
                reputation: i)
            return user
        }
        
        return Items(items: users)
    }
    
    func givenMockViewController() {
        mockViewController = MockViewController(viewModel: sut)
        mockViewController.bind()
    }
    
    func givenError() {
        error = NSError(domain: "com.SOTopTwentyTests", code: 99)
    }

    func testCanCreateMainViewModelWithStackOverflowService() {
 
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.networkService)
    }
    
    func testGivenUsersReturnedFromStackOverflowCLientUsersVariableSet() {
        let users = givenUsers()
        sut.retrieveUsers()
        service.getUsersCompletion(users, nil)
        XCTAssertEqual(service.getUsersCallCount, 1)
        XCTAssertEqual(sut.users.value.count, 3)
    }
    
    func testGivenErrorReturnedFromStackOverflowClientErrorVariableSet() {
        
        givenError()
        sut.retrieveUsers()
        
        service.getUsersCompletion(nil, error)
        
        XCTAssertEqual(service.getUsersCallCount, 1)
        XCTAssertEqual(sut.error.value.localizedDescription, error.localizedDescription)
    }
    
    func testGivenUsersReturnedFromStackOverflowClientControllerBindsToUsers () {
        givenMockViewController()
        let users = givenUsers()
        
        sut.retrieveUsers()
        service.getUsersCompletion(users, nil)
        
        XCTAssertTrue(mockViewController.bindsToUser)
        XCTAssertEqual(mockViewController.users?.count, 3)
        XCTAssertNil(mockViewController.error)
        
    }
    
    func testGivenAnErrorReturnedFRomStackOverflowCLientControllerBindsToError () {
        
        givenMockViewController()
        givenError()
        
        sut.retrieveUsers()
        service.getUsersCompletion(nil, error)
        
        XCTAssertTrue(mockViewController.bindsToError)
        XCTAssertEqual(mockViewController.error?.localizedDescription, error.localizedDescription)
        XCTAssertNil(mockViewController.users)
    }

}

class MockStackOverflowClient: StackOverflowService {
    
    var getUsersCallCount = 0
    var getUsersDataTask = URLSession(configuration: .default).dataTask(with: URL(string: "http://example.com")!)
    var getUsersCompletion: ((Items?, Error?) -> Void)!
    func getUsers(completion: @escaping (Items?, Error?) -> Void) -> URLSessionDataTask {
        getUsersCompletion = completion
        getUsersCallCount += 1
        return getUsersDataTask
    }
}

class MockViewController {
    var viewModel: MainViewModel
    var users: [User]?
    var error: Error?
    var bindsToUser = false
    var bindsToError = false
    
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func bind() {
        viewModel.users.bind {
            self.users = $0
            self.bindsToUser = true
        }
        
        viewModel.error.bind {
            self.error = $0
            self.bindsToError = true
        }
    }
}


