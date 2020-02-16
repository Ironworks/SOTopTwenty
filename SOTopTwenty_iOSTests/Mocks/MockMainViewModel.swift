//
//  MockMainViewModel.swift
//  SOTopTwenty_iOSTests
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//
import SOTopTwentyKit

class MockMainViewModel: MainViewModelProtocol {
    var networkService: StackOverflowService
    var users: Dynamic<[CellViewModel]> = Dynamic([CellViewModel]())
    var error: Dynamic<Error> = Dynamic(NSError())
    
    var retrieveUsersCalled = false
    
    required init(service: StackOverflowService) {
        self.networkService = service
     }
    
    func givenUsers(count: Int = 3) -> Items {
         let users: [User]  = (1...count).map { i in
             let user = User(profileImage: "http://example.com/\(i)",
                 userName: "name\(i)",
                 reputation: i)
             return user
         }
         
         return Items(items: users)
     }
    
    func retrieveUsers() {
        retrieveUsersCalled = true
        
        self.users.value = givenUsers().items.map { CellViewModel(user: $0) }    }
    
    
}
