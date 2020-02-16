//
//  Items.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public struct Items: Decodable, Equatable {
    public let items: [User]
    
    public init(items: [User]) {
        self.items = items
    }
}
