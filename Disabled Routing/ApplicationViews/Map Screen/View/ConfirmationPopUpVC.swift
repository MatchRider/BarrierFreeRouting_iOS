//
//  ConfirmationPopUpVC.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

protocol ConfirmationPopUpVCDelegate:class {
    func confimationYesButtonTapped(forType type:Int)
    func confimationNoButtonTapped()
}

class ConfirmationPopUpVC: BaseViewController {
    @IBOutlet weak var buttonNo: CustomButton!
    @IBOutlet weak var buttonOK: CustomButton!
    
    @IBOutlet weak var buttonDismiss: UIButton!
    @IBOutlet weak var labelHelp: UILabel!
    var message : String!
    var type : Int!
    weak var delegate : ConfirmationPopUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelHelp.text = message
        self.buttonNo.setTitle(AppConstants.ScreenSpecificConstant.Common.NO_TITLE, for: .normal)
        self.buttonOK.setTitle(AppConstants.ScreenSpecificConstant.Common.YES_TITLE, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    @IBAction func noButtonTapped(_ sender: Any) {
       
        self.dismiss(animated: true) {
             self.delegate?.confimationNoButtonTapped()
        }
    }
    @IBAction func yesButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.confimationYesButtonTapped(forType: self.type)
        }
    }
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
