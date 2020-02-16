//
//  ImageClientTests.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwentyKit
@testable import SOTopTwenty_iOS

import XCTest

class ImageClientTests: XCTestCase {
    
    var mockSession: MockURLSession!
    var sut: ImageClient!
    var service: ImageService {
        return sut as ImageService
    }
    var url: URL!
    var recievedDataTask: MockURLSessionDataTask!
    var receivedError: Error!
    var recievedImage: UIImage!
    var expectedImage: UIImage!
    var expectedError: NSError!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        url = URL(string: "https://example.com/image")!
        sut = ImageClient(responseQueue: nil, session: mockSession)
    }
    
    override func tearDown() {
        mockSession = nil
        url = nil
        sut = nil
        recievedDataTask = nil
        receivedError = nil
        recievedImage = nil
        expectedImage = nil
        expectedError = nil
        super.tearDown()
    }
    
    func givenExpectedImage() {
        let image = UIImage(named: "placeholder", in: Bundle(for: MainViewController.self), compatibleWith: .current)!
        expectedImage = UIImage(data: image.pngData()!)
    }
    
    func givenExpectedError() {
        expectedError = NSError(domain: "com.SOTopTwentyTests", code: 99, userInfo: nil)
    }
    
    func whenDownloadImage(image: UIImage? = nil, error: Error? = nil) {
        
        recievedDataTask = sut.downloadImage(fromURL: url) { image, error in
            
            self.recievedImage = image
            self.receivedError = error
        } as? MockURLSessionDataTask
        
        if let recievedDataTask = recievedDataTask {
            if let image = image {
                recievedDataTask.completionHandler(image.pngData(), nil, nil)
            } else if let error = error {
                recievedDataTask.completionHandler(nil, nil, error)
            }
        }
    }
    
    func verifyDownloadImageDispatched(image: UIImage? = nil, error: Error? = nil, line: UInt = #line) {
        
        mockSession.givenDispatchQueue()
        sut = ImageClient(responseQueue: .main, session: mockSession)
        
        var recievedThread: Thread!
        let expectation = self.expectation(description: "Completion wasn't called")
        
        let dataTask = sut.downloadImage(fromURL: url) { _, _ in
            recievedThread = Thread.current
            expectation.fulfill()
            } as! MockURLSessionDataTask
        
        dataTask.completionHandler(image?.pngData(), nil, error)
        
        waitForExpectations(timeout: 0.2)
        XCTAssertTrue(recievedThread.isMainThread)
        
    }
    
    func testSharedSetsResponseQueue() {
        XCTAssertEqual(ImageClient.shared.responseQueue, .main)
    }
    
    func testInitSetsCachedImageForURL() {
        XCTAssertEqual(sut.cachedImageForURL, [:])
    }
    
    func testInitSetsCachedTaskForImageView() {
        XCTAssertEqual(sut.cachedTaskForImageView, [:])
    }
    
    func testInitSetsResponseQueue() {
        XCTAssertEqual(sut.responseQueue, nil)
    }
    
    func testInitSetsSession() {
        XCTAssertEqual(sut.session, mockSession)
    }
    
    func testConformsToImageService() {
        XCTAssertTrue((sut as AnyObject) is ImageService)
    }
    
    func TestImageServiceDeclaresDownloadImage() {

        _ = service.downloadImage(fromURL: url) { _, _ in }
    }
    
    func testImageServiceDeclaresImageOnImageView() {
        
        let imageView = UIImageView()
       
        let placeHolder =  UIImage(named: "placeholder", in: Bundle(for: MainViewController.self), compatibleWith: nil)
        
        service.setImage(on: imageView, fromURL: url, withPlaceholder: placeHolder)
    }
    
    func testDownloadImageCreatesExpectedDataTask() {
        whenDownloadImage()
        
        XCTAssertEqual(recievedDataTask.url, url)
    }
    
    func testDownloadImageCallsResumeOnDataTask() {
        whenDownloadImage()
        
        XCTAssertTrue(recievedDataTask.calledResume)
    }
    
    func testDownloadImageGivenImageCallsCompletionWithImage() {
        
        givenExpectedImage()
    
        whenDownloadImage(image: expectedImage)
        
        XCTAssertEqual(expectedImage?.pngData(), recievedImage.pngData())
    }
    
    func testDownloadImageGivenErrorCallsCompletionWithError() {
        
        givenExpectedError()
        
        whenDownloadImage(error: expectedError)
        
        XCTAssertEqual(receivedError as NSError, expectedError)
    }
    
    func testDownloadImageGivenImageDispatchesToReponseQueue() {
        
        givenExpectedImage()

        verifyDownloadImageDispatched(image: expectedImage)
    }
    
    func testDownloadImageGivenErrorDispatchesToResponseQueue() {
        
        givenExpectedError()
        
        verifyDownloadImageDispatched(error: expectedError)
        
    }
}
