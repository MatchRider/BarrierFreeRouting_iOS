//
//  InstructionTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 13/08/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelInstructions: UILabel!
    @IBOutlet weak var imageViewSign: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
