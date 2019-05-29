//
//  SideMenuHeaderFooterView.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 04/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

protocol SideMenuHeaderFooterViewDelegate: class {
    func profileClicked()
}

class SideMenuHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgStar: UIImageView!
    weak var delegate: SideMenuHeaderFooterViewDelegate?

    @IBOutlet weak var btnLogin: UIButton!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.labelTitle.text = "APP_NAME".localized()
        self.viewImage.setCornerCircular(self.viewImage.bounds.size.width/2)
        self.imgView.setCornerCircular(self.imgView.bounds.size.width/2)
        self.addTapGestureOnName()
    }

    func addTapGestureOnName(){

    }
    
    /// Binds header data
    ///
    /// - Parameters:
    ///   - name: String value as user name
    ///   - rating: String value as rating
    func bind(withUserName name: String, rating: String?, imgId: String){
        self.lblName.text = name
        
        if let ratingValue = rating{
            self.lblRating.isHidden = false
            self.imgStar.isHidden = false
            
            self.lblRating.text = ratingValue
        }
        else{
            self.lblRating.isHidden = true
            self.imgStar.isHidden = true
        }
        
        if  !imgId.isEmptyString(){
            imgView.contentMode = .scaleAspectFit
        }else{
            imgView.contentMode = .center
        }
    }
    
    @IBAction func profileClick(_ sender: Any) {
        self.profileClicked()
    }
    
    func profileClicked(){
        self.delegate?.profileClicked()
    }
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        AppInitialViewHandler.sharedInstance.setupInitialViewController()

    }
    
}
