
/*
 This class is used for Customizing Navigation Bar
 */


import Foundation
import UIKit
import LGSideMenuController


extension UIViewController {
    
    
    /**
     These methods will show and hide navigation bar from screen
     */
    
    func showNavigationBar(){
        self.navigationController!.isNavigationBarHidden = false
    }
    func hideNavigationBar(){
        self.navigationController!.isNavigationBarHidden = true
    }
    
    func setNavigationBarAlpha(alpha: CGFloat = 1.0){
        self.navigationController!.navigationBar.alpha = alpha
    }
    
    
    func customizeNavigationBarWithTitle(navigationTitle:String, color: UIColor = UIColor.clear,textColor: UIColor = UIColor.white,isTranslucent: Bool = true) ->Void{
        
        self.navigationController!.navigationBar.barTintColor = color
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.getSanFranciscoSemibold(withSize: 16),NSAttributedString.Key.foregroundColor: textColor]
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = isTranslucent
    }
    
    func customizeNavigationBarWithTitleImage(image:UIImage) ->Void{
        
        self.navigationController!.navigationBar.barTintColor = UIColor.clear
        let imgView = UIImageView(image: image)
        self.navigationItem.titleView = imgView
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationItem.hidesBackButton = true
    }
    
    func customizeNavigationBarWithTitle(navigationTitle:String,withFontSize fontSize:CGFloat,andColor color:UIColor) ->Void{
        
        self.navigationController!.navigationBar.barTintColor = color
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.getFrutigerLight(withSize: fontSize),NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    func customizeNavigationBackButton(color: UIColor = UIColor.white,image :UIImage = #imageLiteral(resourceName: "ic_keyboard_arrow_left_white_48pt")) ->Void{
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backButtonImage: UIImage = image
        let backButton: UIButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.frame = CGRect(x: 0, y: -20, width: 65, height: 23)
        backButton.setTitle(AppConstants.ScreenSpecificConstant.Common.BACK_BUTTON_TITLE, for: .normal)
        backButton.titleLabel!.font =  UIFont.getSanFranciscoSemibold(withSize: 16)
        backButton.setTitleColor(color, for: .normal)

        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
       backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(UIViewController.backButtonClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    
    func addNavigationRightButtonWithTitle(title: String) ->Void{
                
        let skipButton: UIButton = UIButton(type: .custom)
        skipButton.frame = CGRect(x: 0, y: 0, width: 70, height: 23)
        skipButton.titleLabel?.textAlignment = .right
        skipButton.setTitle(title, for: .normal)
        skipButton.titleLabel!.font =  UIFont.getFrutigerLight(withSize: 14)
        skipButton.contentHorizontalAlignment = .right

        let skipBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: skipButton)
        skipButton.addTarget(self, action: #selector(UIViewController.rightButtonClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = skipBarButtonItem
    }
    
    func addNavigationBackButton() ->Void{
        
        
        let backButtonImage: UIImage = #imageLiteral(resourceName: "ic_keyboard_arrow_left_white_48pt")
        let backButton: UIButton = UIButton(type: .custom)
        backButton.contentHorizontalAlignment = .left
        backButton.setImage(backButtonImage, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(UIViewController.backButtonClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    func addNavigationMenuButton() ->Void{
        
        
        let menuButtonImage: UIImage = #imageLiteral(resourceName: "ic_menu_white_48pt")
        let menuButton: UIButton = UIButton(type: .custom)
        menuButton.setImage(menuButtonImage, for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        menuButton.titleLabel!.font =  UIFont.getFrutigerLight(withSize: 14)
        menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(menuButton.imageView?.frame.size.width)!, bottom: 0, right: (menuButton.imageView?.frame.size.width)!);
        menuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: (menuButton.titleLabel?.frame.size.width)!, bottom: 0, right: -((menuButton.titleLabel?.frame.size.width)!+10));
        let menuBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuButton.addTarget(self, action: #selector(UIViewController.menuButtonClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = menuBarButtonItem
    }
    
    func hideMenuButton(){
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func hideBackButton(){
        self.navigationItem.leftBarButtonItem = nil
    }

    
    @objc func backButtonClick() ->Void {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func skipButtonClick() ->Void {
 
    }
    
    @objc func rightButtonClick() ->Void {
        
    }
    
    @objc func menuButtonClick() ->Void {
            (AppDelegate.sharedInstance.kMainViewController?.leftViewController as! SideMenuViewController).viewWillAppear(true)
            AppDelegate.sharedInstance.kMainViewController?.toggleLeftView(animated: true, completionHandler: nil)

    }
}
