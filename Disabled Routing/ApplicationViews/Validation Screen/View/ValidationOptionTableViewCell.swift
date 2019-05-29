//
//  ValidationOptionTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Shubham Sahgal on 20/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class ValidationOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewOption: UIImageView!
    @IBOutlet weak var labelOption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
