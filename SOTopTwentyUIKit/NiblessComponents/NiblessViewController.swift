//
//  NiblessViewController.swift
//  SOTopTwentyUIKit
//
//  Created by Trevor Doodes on 13/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit

open class NiblessViewController: UIViewController {

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favour of initialiser dependency injection."
  )
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favour of initialiser dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported in favour of initialiser dependency injection.")
  }
}

