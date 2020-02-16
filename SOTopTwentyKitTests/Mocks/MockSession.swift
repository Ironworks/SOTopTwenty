//
//  MockSession.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    var queue: DispatchQueue? = nil
    
    func givenDispatchQueue() {
        queue = DispatchQueue(label: "com.DogPatchTests.MockSession")
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, url: url, queue: queue)
    }
}
