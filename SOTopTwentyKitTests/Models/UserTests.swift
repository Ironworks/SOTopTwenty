//
//  UserTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
import XCTest

class UserTests: XCTestCase, DecodableTestCase {

    var dictionary: [String : Any]!
    var sut: User!
    
    override func setUp() {
        super.setUp()
        try! givenSUTFromJSON()
    }

    override func tearDown() {
        dictionary = nil
        sut = nil
        super.tearDown()
    }
    
    func testConformsToDecodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func testConformsToEquqatable() {
        XCTAssertEqual(sut, sut)
    }
    
    func testDecodableSetsProfileImage() throws {
        try XCTAssertEqualToAny(sut.profileImage, dictionary["profile_image"])
    }

    func testDecodableSetsUserName() throws {
        try XCTAssertEqualToAny(sut.userName, dictionary["display_name"])
    }
    
    func testDecodableSetsReputation() throws {
        try XCTAssertEqualToAny(sut.reputation, dictionary["reputation"])
    }

}
