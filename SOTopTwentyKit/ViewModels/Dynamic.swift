//
//  Dynamic.swift
//  SOTopTwentyKit
//
//  Created by Trevor Doodes on 15/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import Foundation

public class Dynamic<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
    }
    
    public func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public init(_ v: T) {
        value = v 
    }
}
