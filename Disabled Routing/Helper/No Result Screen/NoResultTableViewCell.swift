//
//  NoResultTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 12/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class NoResultTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(title: String){
        self.lblMessage.text = title
    }
}
