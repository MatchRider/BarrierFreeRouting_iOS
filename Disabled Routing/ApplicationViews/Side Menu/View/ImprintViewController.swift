//
//  ImprintViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class ImprintViewController: BaseViewController,UITextViewDelegate {

    @IBOutlet weak var textViewImprint4: UITextView!
    @IBOutlet weak var textViewImprint3: UITextView!
    @IBOutlet weak var textViewImprint2: UITextView!
    @IBOutlet weak var textViewImprint1: UITextView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewImprint: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textViewImprint1.delegate = self
        self.textViewImprint2.delegate = self
        self.textViewImprint3.delegate = self
        self.textViewImprint4.delegate = self
        self.textViewImprint1.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_1
            self.textViewImprint2.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_2
            self.textViewImprint3.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_3
            self.textViewImprint4.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_4
        self.labelTitle.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigationBar()
    }
    private func attributedTextForImprint() -> NSMutableAttributedString
    {
        let fullString = NSMutableAttributedString(string: AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_1)
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = #imageLiteral(resourceName: "20171024_DigitalBW_LOGO_CMYK_RZ_Subline")
        
        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_2))
        fullString.append(image1String)
         fullString.append(NSAttributedString(string: AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_3))
         fullString.append(image1String)
       fullString.append(NSAttributedString(string: AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT_DETAIL_PART_4))
        return fullString
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }

}
