//
//  CellViewModel.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public class CellViewModel {
        
    public var userName: Dynamic<String> = Dynamic("")
    public var reputation: Dynamic<Int> = Dynamic(0)
    public var profileImage: Dynamic<String> = Dynamic("")
    public var isFollowing: Dynamic<Bool> = Dynamic(false)
    public var isBlocked: Dynamic<Bool> = Dynamic(false)
    public var isExpanded: Dynamic<Bool> = Dynamic(false)
    
    public init(user: User) {
        self.userName.value = user.userName
        self.reputation.value = user.reputation
        self.profileImage.value = user.profileImage
    }
    
    public func toggleIsFollowing() {
        isFollowing.value = !isFollowing.value
    }
    
    public func toggleIsBlocked() {
        isBlocked.value = !isBlocked.value
    }
    
    public func toggleIsExpanded() {
        isExpanded.value = !isExpanded.value
    }
    
}




