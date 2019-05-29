//
//  SideMenuItemTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 04/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class SideMenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblItemSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(withItemName name: String, imgItem: UIImage, subTitle: String){
        self.lblItem.text = name
        self.imgViewItem.image = imgItem
        self.lblItemSubtitle.text = subTitle
    }
    
}
