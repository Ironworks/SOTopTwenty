//
//  StackOverflowClient.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

public protocol StackOverflowService {
    func getUsers(completion: @escaping (Items?, Error?) -> Void) -> URLSessionDataTask
}
import Foundation

public class StackOverflowClient: StackOverflowService {
      let baseURL: URL
      let session: URLSession
      let responseQueue: DispatchQueue?
      
      
      public static let shared = StackOverflowClient(baseURL: URL(string: "https://api.stackexchange.com/2.2/")!,
                                         session: URLSession.shared,
                                         responseQueue: .main)
      
      public init(baseURL: URL, session: URLSession, responseQueue: DispatchQueue?) {
        self.baseURL = baseURL
        self.session = session
        self.responseQueue = responseQueue
      }
      
      public func getUsers(completion: @escaping (Items?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: "users?pagesize=20&order=desc&sort=reputation&site=stackoverflow", relativeTo: baseURL)!
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
          
          guard let self = self else { return }
          guard let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            error == nil,
            let data = data
          else {
            self.dispatchResult(error: error, completion: completion)
            return
          }
          
          let decoder = JSONDecoder()
          do {
            let items = try decoder.decode(Items.self, from: data)
            self.dispatchResult(models: items, error: error, completion: completion)
            
          } catch {
            self.dispatchResult(error: error, completion: completion)
          }
        }
        task.resume()
        
        return task
      }
      
      private func dispatchResult<Type>(models: Type? = nil,
                                        error: Error?,
                                        completion: @escaping (Type?, Error?) -> Void) {
        
        guard let responseQueue = responseQueue else {
          completion(models, error)
          return
        }
        responseQueue.async {
          completion(models, error)
        }
    }
}


