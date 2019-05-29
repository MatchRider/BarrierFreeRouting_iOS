//
//  YesPopUpVC.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
protocol YesPopUpVCDelegate:class {
    func okBetterLookButtonTapped()
}
class YesPopUpVC: BaseViewController {
    @IBOutlet weak var labelCloser: UILabel!
    @IBOutlet weak var buttonOK: CustomButton!
    weak var delegate : YesPopUpVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelCloser.text = AppConstants.ScreenSpecificConstant.MapScreen.LOOK_CLOSER_TEXT_WAY
        self.buttonOK.setTitle(AppConstants.ScreenSpecificConstant.MapScreen.OK_TEXT, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    @IBAction func okButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.okBetterLookButtonTapped()
        }
        
        

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
