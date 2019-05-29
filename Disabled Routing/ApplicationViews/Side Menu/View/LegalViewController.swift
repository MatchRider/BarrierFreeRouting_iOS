//
//  LegalViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 17/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class LegalViewController: BaseViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewLegal: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewLegal.text = AppConstants.ScreenSpecificConstant.LegalController.LEGAL_TEXT
        labelTitle.text = AppConstants.ScreenSpecificConstant.SideMenuScreen.LEGAL
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
