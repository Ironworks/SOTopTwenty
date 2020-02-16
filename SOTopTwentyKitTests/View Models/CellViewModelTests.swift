//
//  CellViewModelTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
import XCTest

class CellViewModelTests: XCTestCase {
    
    var sut: CellViewModel!
    var user: User!
    var mockCell: MockCell!

    override func setUp() {
        super.setUp()
        whenSUTSetFromUser()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func givenMockCell() {
        mockCell = MockCell(viewModel: sut)
        mockCell.bind()
    }
    
    func whenSUTSetFromUser(profileImage: String = "http://example.com",
                            userName: String = "name",
                            reputation: Int = 99) {
        
        user = User(profileImage: profileImage,
                        userName: userName,
                        reputation: reputation)
        sut = CellViewModel(user: user)

    }
        
    func testInitSetsName() {
        XCTAssertEqual(sut.userName.value, "name")
    }
    
    func testInitSetsReputation() {
        XCTAssertEqual(sut.reputation.value, 99)
    }
    
    func testIsFollowingInitiallySetToFalse() {
        XCTAssertEqual(sut.isFollowing.value, false)
    }
    
    func testIsBlockedInitiallySetToFalse() {
        XCTAssertEqual(sut.isBlocked.value, false)
    }
    
    func testIsExpandedInitiallySetToFalse() {
        XCTAssertEqual(sut.isExpanded.value, false)
    }
    
    func testGiveUserNameChangesCellBindsToUserName() {
        givenMockCell()
        sut.userName.value = "updated name"
        XCTAssertEqual(mockCell.userName, sut.userName.value)
        XCTAssertTrue(mockCell.bindsToUserName)
    }
    
    func testGivenReputationChangesCellBindsToReputation() {
        givenMockCell()
        sut.reputation.value = 2000
        XCTAssertEqual(mockCell.reputation, sut.reputation.value)
        XCTAssertTrue(mockCell.bindsToReputation)
    }
    
    func testWhenIsFollowingChangesCellBindsToIsFollowing() {
        givenMockCell()
        sut.toggleIsFollowing()
        XCTAssertEqual(mockCell.isFollowing, sut.isFollowing.value)
        XCTAssertTrue(mockCell.bindsToIsFollowing)
    }

    func testWhenIsBlockedChangedBindsToIsBlocked() {
        givenMockCell()
        sut.toggleIsBlocked()
        XCTAssertEqual(mockCell.isBlocked, sut.isBlocked.value)
        XCTAssertTrue(mockCell.bindsToIsBlocked)
    }
    
    func testWhenIsExpandedChangedBindsToIsExpanded() {
        givenMockCell()
        sut.toggleIsExpanded()
        XCTAssertEqual(mockCell.isExpanded, sut.isExpanded.value)
        XCTAssertTrue(mockCell.bindsToIsExpanded)
    }

}

class MockCell {
    
    var viewModel: CellViewModel
    
    var userName: String?
    var reputation: Int?
    var isFollowing: Bool?
    var isBlocked: Bool?
    var isExpanded: Bool?
    

    var bindsToUserName = false
    var bindsToReputation = false
    var bindsToIsFollowing = false
    var bindsToIsBlocked = false
    var bindsToIsExpanded = false
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
    }
    
    func bind() {
        
        viewModel.userName.bind {
            self.userName = $0
            self.bindsToUserName = true
        }
        
        viewModel.reputation.bind {
            self.reputation = $0
            self.bindsToReputation = true
        }
        
        viewModel.isFollowing.bind {
            self.isFollowing = $0
            self.bindsToIsFollowing = true
        }
        
        viewModel.isBlocked.bind {
            self.isBlocked = $0
            self.bindsToIsBlocked = true
        }
        
        viewModel.isExpanded.bind {
            self.isExpanded = $0
            self.bindsToIsExpanded = true
        }
    }
}
