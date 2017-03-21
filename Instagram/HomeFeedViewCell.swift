//
//  HomeFeedViewCell.swift
//  Instagram
//
//  Created by Arnav Jain on 3/20/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit

class HomeFeedViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
