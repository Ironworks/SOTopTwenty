//
//  MainViewModel.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

class MainViewModel {
    let networkService: StackOverflowService
    var users: Dynamic<[User]> = Dynamic([User]())
    var error: Dynamic<Error> = Dynamic(NSError())
    
    
    init(service: StackOverflowService) {
        self.networkService = service
    }
    
    func retrieveUsers() {
        _ = networkService.getUsers { items, error in
            guard let users = items?.items else {
                guard let error = error else { return }
                self.error.value = error
                return
            }
            self.users.value = users
        }
    }
}
