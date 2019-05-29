//
//  CorrectionTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 21/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class CorrectionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelVerified: UILabel!
    @IBOutlet weak var buttonCheckBox: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var labelOption: UILabel!
    @IBOutlet weak var labeltitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelVerified.text = "VERIFIED".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
