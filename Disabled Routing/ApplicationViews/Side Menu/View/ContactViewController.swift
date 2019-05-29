//
//  ContactViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import MessageUI
class ContactViewController: BaseViewController {

    @IBOutlet weak var buttonSend: CustomButton!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldQuery: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = "CONTACT".localized()
        labelText.text = "TEXT".localized()
        buttonSend.setTitle("SEND".localized(), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigationBar()
    }
    @IBAction func sendButtonTapped(_ sender: Any) {
        if isValidSubmisstion() {
            sendEmail(fromEmail: self.textFieldEmail.text!, withBody: self.textFieldQuery.text!, fromName: self.textFieldName.text!)
        }
        
    }
    private func isValidSubmisstion() -> Bool {
        
        guard !(self.textFieldName.text?.isEmpty)!,!(self.textFieldEmail.text?.isEmpty)!,!(self.textFieldQuery.text?.isEmpty)! else {
            return false
        }
        
        guard (self.textFieldEmail.text?.isValidEmailId())! else {
             return false
        }
        
        return true
    }

    func sendEmail(fromEmail email:String,withBody body:String,fromName name:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([AppConstants.ScreenSpecificConstant.ContactScreen.RECPIENT_MAIL])
            mail.setMessageBody("<h4>Hi,</h4><p>\(body)</p><p>Thanks,</p><p>\(name)</p>", isHTML: true)
            mail.setSubject(AppConstants.ScreenSpecificConstant.ContactScreen.EMAIL_SUBJECT)
            if #available(iOS 11.0, *) {
                mail.setPreferredSendingEmailAddress(email)
            } else {
                // Fallback on earlier versions
            }
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    

}
extension ContactViewController:MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
