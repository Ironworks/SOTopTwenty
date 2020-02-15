//
//  Users.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

class User: Decodable {
    let profileImage: String
    let userName: String
    let reputation: Int
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case userName = "display_name"
        case reputation
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.profileImage == rhs.profileImage &&
            lhs.userName == rhs.userName &&
            lhs.reputation == rhs.reputation
    }
}
