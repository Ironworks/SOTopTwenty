//
//  Users.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public class User: Decodable {
    let profileImage: String
    let userName: String
    let reputation: Int
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case userName = "display_name"
        case reputation
    }
    
    public init(profileImage: String, userName: String, reputation: Int) {
        self.profileImage = profileImage
        self.userName = userName
        self.reputation = reputation
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.profileImage == rhs.profileImage &&
            lhs.userName == rhs.userName &&
            lhs.reputation == rhs.reputation
    }
}
