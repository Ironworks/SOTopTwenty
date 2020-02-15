//
//  ItemsTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
import XCTest

class ItemsTests: XCTestCase, DecodableTestCase {
    
    var dictionary: [String : Any]!
    var sut: Items!
    
    override func setUp() {
        super.setUp()
        try! givenSUTFromJSON()
    }

    func testConformsToDecodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func testConformsToEquatable() {
        XCTAssertEqual(sut, sut)
    }
    
    func testDecodableSetsItems() throws {
        try XCTAssertEqualToAny(sut.items.count, 20)
    }
}
