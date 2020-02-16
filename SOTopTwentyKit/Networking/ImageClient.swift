//
//  ImageClient.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit

protocol ImageService {
    func downloadImage(fromURL url: URL, completion: @escaping (UIImage?, Error?) -> Void) -> URLSessionDataTask
    func setImage(on imageView: UIImageView, fromURL: URL, withPlaceholder: UIImage?)
}

class ImageClient {
    
    static let shared = ImageClient(responseQueue: .main,
                                    session: .shared)
    
    var cachedImageForURL: [URL: UIImage]
    var cachedTaskForImageView: [UIImageView: URLSessionDataTask]
    
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    init(responseQueue: DispatchQueue?, session: URLSession) {
        self.cachedImageForURL = [:]
        self.cachedTaskForImageView = [:]
        
        self.responseQueue = responseQueue
        self.session = session
    }
    
}

extension ImageClient: ImageService {
    
    func downloadImage(fromURL url: URL, completion: @escaping (UIImage?, Error?) -> Void) -> URLSessionDataTask {
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let data = data, let image = UIImage(data: data) {
                self.dispatch(image: image, completion: completion)
            } else {
                self.dispatch(error: error, completion: completion)
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
    private func dispatch(image: UIImage? = nil,
                          error: Error? = nil,
                          completion: @escaping (UIImage?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, error)
        }
    }
    
    func setImage(on imageView: UIImageView, fromURL: URL, withPlaceholder: UIImage?) {
        
    }
}
