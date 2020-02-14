//
//  NiblessView.swift
//  SOTopTwentyUIKit
//
//  Created by Trevor Doodes on 13/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit

open class NiblessView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favour of initialiser dependency injection.")
    public required init?(coder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favour of initialiser dependency injection.")
    }
    
}
