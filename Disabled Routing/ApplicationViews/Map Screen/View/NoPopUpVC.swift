//
//  NoPopUpVC.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
protocol NoPopUpVCDelegate : class {
    func okNextTimeButtonTapped()
}
class NoPopUpVC: BaseViewController {
    weak var delegate : NoPopUpVCDelegate?
    @IBOutlet weak var buttonOK: CustomButton!
    @IBOutlet weak var labelPity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelPity.text = AppConstants.ScreenSpecificConstant.MapScreen.NEXT_TIME_TEXT
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
        self.delegate?.okNextTimeButtonTapped()
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
