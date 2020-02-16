//
//  MainViewController.swift
//  SOTopTwenty_iOS
//
//  Created by Trevor Doodes on 13/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit
import SOTopTwentyKit
import SOTopTwentyUIKit

public class MainViewController: NiblessViewController {
    
    var viewModel: MainViewModel
    private let tableView: UITableView
    
    
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        tableView = UITableView()
        super.init()
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        viewModel.retrieveUsers()
    }
    
    private func configureUI () {
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
}
