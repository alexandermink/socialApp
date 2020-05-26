//
//  TableViewCell.swift
//  socialApp
//
//  Created by Александр Минк on 19.05.2020.
//  Copyright © 2020 Alexander Mink. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarControl: AvatarView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

