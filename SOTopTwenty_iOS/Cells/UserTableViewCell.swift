//
//  UserTableViewCell.swift
//  SOTopTwenty_iOS
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit
import SOTopTwentyKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    
    private var viewModel: CellViewModel?
    
    override func prepareForReuse() {
        userNameLabel.text = ""
        reputationLabel.text = ""
        favouriteImageView.image = nil
    }
    
    
    func configure(viewModel: CellViewModel) {
        self.viewModel = viewModel
        userNameLabel.text = viewModel.userName.value
        reputationLabel.text = "\(viewModel.reputation.value)"
        favouriteImageView.image = viewModel.isFollowing.value ? UIImage(named: "favourite", in: Bundle(for: Self.self), with: nil) : nil
        setupButtons()
        bind()
    }
    
    private func setupButtons() {
        followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockButtonPressed), for: .touchUpInside)
        if let expanded = viewModel?.isExpanded.value {
            followButton.isHidden = !expanded
            blockButton.isHidden = !expanded
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
            self.followButton.setTitle(bool ? "Following" : "Follow", for: .normal)
            
            self.favouriteImageView.image = bool ?  UIImage(named: "favourite", in: Bundle(for: Self.self), with: nil) : nil
        }
        
        viewModel?.isBlocked.bind { bool in
            self.blockButton.setTitle(bool ? "Blocked" : "Block", for: .normal)
            self.followButton.isEnabled = false
            self.blockButton.isEnabled = false
            self.isUserInteractionEnabled = false
            self.userNameLabel.textColor = bool ? .gray : .black
            self.reputationLabel.textColor = bool ? .gray : .black
        }
        
        viewModel?.isExpanded.bind { bool in
            self.blockButton.isHidden = !bool
            self.followButton.isHidden = !bool 
        }
    }
    

    
}
