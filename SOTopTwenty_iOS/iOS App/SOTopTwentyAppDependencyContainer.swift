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
    
    let service = StackOverflowClient.shared
    
    public init() {}
    
    public func createMainViewModel() -> MainViewModel {
        return MainViewModel(service: service)
    }
    
    public func createMainNavigationContoller() -> UINavigationController {
        let mainViewController =  MainViewController(viewModel: createMainViewModel())
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        return navigationController
    }
}
