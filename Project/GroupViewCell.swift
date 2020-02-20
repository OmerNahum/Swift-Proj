//
//  GroupViewCell.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class GroupViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
