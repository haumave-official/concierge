//
//  chatCellTableViewCell.swift
//  conciergebeta
//
//  Created by Max Suvorov on 29.10.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import UIKit

class chatCellTableViewCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.messageBubble.layer.cornerRadius = 15
        self.messageBubble.layer.shouldRasterize = true
        self.messageBubble.layer.rasterizationScale = UIScreen.main.scale
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
