//
//  TutorialScreenViewController.swift
//  Disabled Routing
//
//  Created by Daffodil_pc on 18/12/18.
//  Copyright © 2018 Daffodil_pc. All rights reserved.
//

import UIKit

class TutorialScreenViewController: UIViewController {

    
    @IBOutlet weak var imageViewTutorial: UIImageView!
    var image : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewTutorial.image = image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
