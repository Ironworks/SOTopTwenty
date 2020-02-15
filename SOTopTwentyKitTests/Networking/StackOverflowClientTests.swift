//
//  StackOverflowClientTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
import XCTest

class StackOverFlowClientTests: XCTestCase {
    
      var baseURL: URL!
      var session: MockURLSession!
      var sut: StackOverflowClient!
      
      var getUsersURL: URL {
        return URL(string: "users?pagesize=20&order=desc&sort=reputation&site=stackoverflow", relativeTo: baseURL)!
      }
      
      override func setUp() {
        super.setUp()
        baseURL = URL(string: "https://example.com/api/v1")!
        session = MockURLSession()
        sut = StackOverflowClient(baseURL: baseURL, session: session, responseQueue: nil)
      }
      
      override func tearDown() {
        baseURL = nil
        session = nil
        sut = nil
        super.tearDown()
      }
      
      func whenGetUsers(data: Data? = nil,
                       statusCode: Int = 200,
                       error: Error? = nil) -> (calledCompletion: Bool, items: Items?, error: Error?){

        let response = HTTPURLResponse(url: getUsersURL,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)!

        var calledCompletion = false
        var receivedItems: Items? = nil
        var receivedError: Error? = nil
        let mockTask = sut.getUsers() { items, error in
          calledCompletion = true
          receivedItems = items
          receivedError = error
          } as! MockURLSessionDataTask

        mockTask.completionHandler(data, response, error)

        return (calledCompletion, receivedItems, receivedError)

      }

      func verifyGetUsersDispatchedToMain(data: Data? = nil,
                                         statusCode: Int = 200,
                                         error: Error? = nil,
                                         line: UInt = #line) {

        session.givenDispatchQueue()
        sut = StackOverflowClient(baseURL: baseURL, session: session, responseQueue: .main)
        let expectation = self.expectation(description: "Completion wasn't called")

        var thread: Thread!
        let mockTask = sut.getUsers() { items, error in
          thread = Thread.current
          expectation.fulfill()
        } as! MockURLSessionDataTask

        let response = HTTPURLResponse(url: getUsersURL,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil)!
        mockTask.completionHandler(data, response, error)

        waitForExpectations(timeout: 0.2) { _ in
          XCTAssertTrue(thread.isMainThread, line: line)
        }
      }

      func testConformsToStackOverflowSevice() {
        XCTAssertTrue((sut as AnyObject) is StackOverflowService)
      }

      func testStackOverflowServiceDeclaresGetDogs() {
        let service = sut as StackOverflowService

        _ = service.getUsers() { _, _ in }
      }

      func testSharedSetsBaseURL() {
        let baseURL = URL(string: "https://api.stackexchange.com/2.2/")!

        XCTAssertEqual(StackOverflowClient.shared.baseURL, baseURL)
      }

      func testSharedSetsSession() {
        let session = URLSession.shared

        XCTAssertEqual(StackOverflowClient.shared.session, session)
      }

      func testShared_setsResponseQueue() {
        let responseQueue = DispatchQueue.main

        XCTAssertEqual(StackOverflowClient.shared.responseQueue, responseQueue)
      }

      func testInitSetsBaseURL() {
        XCTAssertEqual(sut.baseURL, baseURL)
      }

      func testInitSetsSession() {
        XCTAssertEqual(sut.session, session)
      }

      func testInitSetsResponseQueue() {
        let responseQueue = DispatchQueue.main

        sut = StackOverflowClient(baseURL: baseURL, session: session, responseQueue: responseQueue)

        XCTAssertEqual(sut.responseQueue, responseQueue)
      }

      func testGetUsersCallsExpectedURL() {
        let mockTask = sut.getUsers() {_, _ in } as! MockURLSessionDataTask

        XCTAssertEqual(mockTask.url, getUsersURL)
      }

      func testGetusersCalls_resumeOnTask() {
        let mockTask = sut.getUsers() { _, _ in } as! MockURLSessionDataTask

        XCTAssertTrue(mockTask.calledResume)
      }

      func testGetUsersGivesResponseStatusCode500CallsCompletion() {

        let result = whenGetUsers(statusCode: 500)

        XCTAssertTrue(result.calledCompletion)
        XCTAssertNil(result.items)
        XCTAssertNil(result.error)

      }

      func testGetUsersGivenErrorCallsCompletionWithError() throws {

        let expectedError = NSError(domain: "com.SOTopTwentyKitTests", code: 99)

        let result = whenGetUsers(error: expectedError)

        XCTAssertTrue(result.calledCompletion)
        XCTAssertNil(result.items)

        let actualError = try XCTUnwrap(result.error as NSError?)
        XCTAssertEqual(actualError, expectedError)

      }

      func testGetUsersGivenValidJSONCallsCompletionWithDogs() throws {

        let data = try Data.fromJSON(fileName: "Items")

        let decoder = JSONDecoder()
        let items = try decoder.decode(Items.self, from: data)

        let result = whenGetUsers(data: data)

        XCTAssertTrue(result.calledCompletion)
        XCTAssertEqual(result.items, items)
        XCTAssertNil(result.error)
      }

      func testGetUsersGivenInvalidJSONCallsCompletionWithError() throws {

        let data = try Data.fromJSON(fileName: "GetUsersMissingValuesResponse")
        var expectedError: NSError!
        let decoder = JSONDecoder()
        do {
          _ = try decoder.decode(Items.self, from: data)
        } catch {
          expectedError = error as NSError
        }

        let result = whenGetUsers(data: data)

        XCTAssertTrue(result.calledCompletion)

        let actualError = try XCTUnwrap(result.error as NSError?)
        XCTAssertEqual(actualError.domain, expectedError.domain)
        XCTAssertEqual(actualError.code, expectedError.code)
      }

      func testGetUsersGivenHTTPStatusErrorDispatchToResponseQueue() {
        verifyGetUsersDispatchedToMain(statusCode: 500)
      }

      func testGetUsersGivenErrorDispatchesToResponseQueue() {
        let error = NSError(domain: "com.SOTopTwentyKitTests", code: 99)

        verifyGetUsersDispatchedToMain(error: error)
      }

      func testGetUsersGivenGoodResponseDispatchesToResponseQueue() throws {
        let data = try Data.fromJSON(fileName: "Items")

        verifyGetUsersDispatchedToMain(data: data)
      }

      func testGetUsersGivenInvalidResponseDispatchsToResponseQueue() throws {
        let data = try Data.fromJSON(fileName: "GetUsersMissingValuesResponse")

        verifyGetUsersDispatchedToMain(data: data)
      }
}

class MockURLSession: URLSession {
    
    var queue: DispatchQueue? = nil
    
    func givenDispatchQueue() {
        queue = DispatchQueue(label: "com.DogPatchTests.MockSession")
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, url: url, queue: queue)
    }
}
    
class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse, Error?) -> Void
    var url: URL
    var calledResume = false
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, url: URL, queue: DispatchQueue?) {
        if let queue = queue {
            self.completionHandler = { data, response, error in
                queue.async {
                    completionHandler(data, response, error)
                }
            }
        } else {
            self.completionHandler = completionHandler
        }
        
        self.url = url
        super.init()
    }
    
    override func resume() {
        calledResume = true
    }
}
