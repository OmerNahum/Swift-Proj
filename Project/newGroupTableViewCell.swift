//
//  newGroupTableViewCell.swift
//  Project
//
//  Created by Studio on 13/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class newGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var participantName: UILabel!
    
    @IBOutlet weak var infoGroupLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
