//
//  AssertEqualToAny.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import XCTest

public func XCTAssertEqualToAny<T: Equatable>(_ actual: @autoclosure () throws -> T,
                                              _ expected: @autoclosure () throws -> Any?,
                                              file: StaticString = #file,
                                              line: UInt = #line) throws {
  let actual = try actual()
  let expected = try XCTUnwrap(expected() as? T)
  XCTAssertEqual(actual, expected, file: file, line: line)
}
