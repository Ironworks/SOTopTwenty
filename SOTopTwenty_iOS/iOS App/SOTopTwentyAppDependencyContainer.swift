//
//  SOTopTwentyAppDependencyContainer.swift
//  SOTopTwenty_iOS
//
//  Created by Trevor Doodes on 13/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import SOTopTwentyKit
import UIKit

public class SOTopTwentyAppDependencyContainer {
    
    public init() {}
    
    public func createMainNavigationContoller() -> UINavigationController {
        let mainViewController =  MainViewController() 
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        return navigationController
    }
}