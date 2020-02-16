//
//  CellViewModel.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

class CellViewModel {
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            self.userName.value = user.userName
            self.reputation.value = user.reputation
        }
    }
    
    var userName: Dynamic<String> = Dynamic("")
    var reputation: Dynamic<Int> = Dynamic(0)
    var isFollowing: Dynamic<Bool> = Dynamic(false)
    var isBlocked: Dynamic<Bool> = Dynamic(false)
    
    
    func toggleIsFollowing() {
        isFollowing.value = !isFollowing.value
    }
    
    func toggleIsBlocked() {
        isBlocked.value = !isBlocked.value
    }
    
}




