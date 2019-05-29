//
//  PageThreeViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 14/02/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class LastTutorialViewController: UIViewController {

    @IBOutlet weak var buttonStart: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
buttonStart.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        buttonStart.makeViewCircular()
        buttonStart.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startButtonTapped(_ sender: Any) {
        self.navigateToAppHomeScreen()
    }
    
    private func navigateToAppHomeScreen()
    {
        UserDefaultUtility.saveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_VISITED, value: true)
        AppInitialViewHandler.sharedInstance.setupInitialViewController()
    }

}
