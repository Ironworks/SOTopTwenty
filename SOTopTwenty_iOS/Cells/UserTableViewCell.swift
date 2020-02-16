//
//  UserTableViewCell.swift
//  SOTopTwenty_iOS
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit
import SOTopTwentyKit


public protocol UserTableViewCellDelegate: class {
    func updateTableView()
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var greyView: UIView!
    
    private var viewModel: CellViewModel?
    
    weak var delegate: UserTableViewCellDelegate?
    
    override func prepareForReuse() {
        userNameLabel.text = ""
        reputationLabel.text = ""
        favouriteImageView.image = nil
        greyView.isHidden = true
        self.isUserInteractionEnabled = true
    }
    
    
    func configure(viewModel: CellViewModel) {
        self.viewModel = viewModel
        userNameLabel.text = viewModel.userName.value
        reputationLabel.text = "\(viewModel.reputation.value)"
        favouriteImageView.image = viewModel.isFollowing.value ? UIImage(named: "favourite", in: Bundle(for: Self.self), with: nil) : nil
        if viewModel.isBlocked.value {
            self.disableCell()
        }
        setupButtons()
        bind()
    }
    
    private func setupButtons() {
        followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockButtonPressed), for: .touchUpInside)
        if let expanded = viewModel?.isExpanded.value {
            showHideButtons(show: expanded)
        }
    }
    
    @objc private func followButtonPressed() {
        viewModel?.toggleIsFollowing()
    }
    
    @objc private func blockButtonPressed() {
        viewModel?.toggleIsBlocked()
    }
    
    private func bind() {
        viewModel?.isFollowing.bind { bool in
            self.followButton.setTitle(bool ? "Unfollow" : "Follow", for: .normal)
            
            self.favouriteImageView.image = bool ?  UIImage(named: "favourite", in: Bundle(for: Self.self), with: nil) : nil
        }
        
        viewModel?.isBlocked.bind { bool in
            self.disableCell()
        }
        
        viewModel?.isExpanded.bind { bool in
            self.showHideButtons(show: bool)
        }
    }
    
    private func disableCell() {
        self.isUserInteractionEnabled = false
        self.viewModel?.isExpanded.value = false
        self.delegate?.updateTableView()
        self.greyView.isHidden = false
    }
    
    private func showHideButtons(show: Bool) {
        self.blockButton.isHidden = !show
        self.followButton.isHidden = !show
    }
    
}
