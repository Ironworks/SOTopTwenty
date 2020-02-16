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
    
    var viewModel: MainViewModelProtocol
    private let tableView: UITableView
    
    var imageClient: ImageService = ImageClient.shared

    public init(viewModel: MainViewModelProtocol) {
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
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "UserTableViewCell")
        tableView.estimatedRowHeight = 178
        
        bind()
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
    
    private func bind() {
        
        viewModel.users.bind { _ in
            self.tableView.reloadData()
        }
        
        viewModel.error.bind { _ in
            let alert = UIAlertController(title: "Network Error", message: "Unable to retrieve data, please check your connection", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let cellModel = viewModel.users.value[indexPath.row]
        cell.configure(viewModel: cellModel)
        if let url = URL(string: cellModel.profileImage.value) {
            imageClient.setImage(on: cell.profileImageView, fromURL: url, withPlaceholder: UIImage(named: "placeholder"))
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
