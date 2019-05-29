//
//  UIImageExtension.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 06/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

extension UIImageView{
     func getImageViewWithImageTintColor(color: UIColor){
        self.tintColor = color
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
    }
    
    func getImageViewWithOutImageTintColor(color: UIColor){
        self.tintColor = color
        self.image = self.image!.withRenderingMode(.alwaysOriginal)
        
    }
}
