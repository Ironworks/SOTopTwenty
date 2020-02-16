//
//  MainViewModel.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public class MainViewModel {
    let networkService: StackOverflowService
    public var users: Dynamic<[CellViewModel]> = Dynamic([CellViewModel]())
    public var error: Dynamic<Error> = Dynamic(NSError())
    
    
    public init(service: StackOverflowService) {
        self.networkService = service
    }
    
    public func retrieveUsers() {
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
