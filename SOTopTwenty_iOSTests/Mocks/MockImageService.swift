//
//  MockImageService.swift
//  SOTopTwentyKitTests
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

@testable import SOTopTwenty_iOS
import UIKit

public class MockImageService: ImageService {
    
    public var setImageCallCount = 0
    public var receivedImageView: UIImageView!
    public var receivedURL: URL!
    public var receivedPlaceHolder: UIImage!
    
    public func downloadImage(fromURL url: URL, completion: @escaping (UIImage?, Error?) -> Void) -> URLSessionDataTask? {
        return nil
    }
    
    public func setImage(on imageView: UIImageView, fromURL url: URL, withPlaceholder placeholder: UIImage?) {
        setImageCallCount += 1
        receivedImageView = imageView
        receivedURL = url
        receivedPlaceHolder = placeholder
    }
}
