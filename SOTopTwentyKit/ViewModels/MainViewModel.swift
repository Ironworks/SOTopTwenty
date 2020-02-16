//
//  MainViewModel.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public protocol MainViewModelProtocol : class {
    
    var networkService: StackOverflowService { get set  }
    var users: Dynamic<[CellViewModel]> { get set }
    var error: Dynamic<Error> { get set }
    init(service: StackOverflowService)
    func retrieveUsers()
}

public class MainViewModel: MainViewModelProtocol {
    public var networkService: StackOverflowService
    public var users: Dynamic<[CellViewModel]> = Dynamic([CellViewModel]())
    public var error: Dynamic<Error> = Dynamic(NSError())
    
    
    required public init(service: StackOverflowService) {
        self.networkService = service
    }
    
    public func retrieveUsers() {
        
        guard InternetConnectionManager.isConnectedToNetwork() else {
            
            let error = NSError(domain: "com.SOTopTwenty", code: 99, userInfo: nil)
            self.error.value = error
            return
        }
        
        
        _ = networkService.getUsers { [weak self] items, error in
            
            guard let self = self else { return }
            guard let users = items?.items else {
                guard let error = error else { return }
                self.error.value = error
                return
            }
            self.users.value = users.map { CellViewModel(user: $0) }
        }
    }
}
