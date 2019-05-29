//
//  DisclaimerViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class DisclaimerViewController: BaseViewController {

    @IBOutlet weak var labelDetail: UITextView!
    @IBOutlet weak var labelTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.DISCLAIMER
         labelDetail.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.COMING_SOON
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideNavigationBar()
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
