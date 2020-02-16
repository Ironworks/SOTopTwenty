//
//  UserTableViewCell.swift
//  SOTopTwenty_iOS
//
//  Created by Trevor Doodes on 16/02/2020.
//  Copyright © 2020 IronworksMediaLimited. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
