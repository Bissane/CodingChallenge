//
//  CCTableViewCell.swift
//  CodingChallenge
//
//  Created by mac on 12/19/17.
//  Copyright © 2017 Bissane. All rights reserved.
//

import UIKit

class CCTableViewCell: UITableViewCell {
    

    @IBOutlet weak var ownerAvatar: UIImageView!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    
    @IBOutlet weak var numberOfStars: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
