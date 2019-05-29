
//Notes:- This class is used to set initial view controller for the app.

import UIKit
import LGSideMenuController

enum InitialViewControllerMode{
    case withSideMenu
    case withoutSideMenu
}

class AppInitialViewHandler: NSObject {
    
    //MARK:- AppInitialViewHandler local properties.
    
    static let sharedInstance = AppInitialViewHandler()
    
    //MARK:- AppInitialViewHandler init.
    private override init(){
        super.init()
    }
    
    //MARK:- Helper methods
    
    /**
     Setup initial view controller for development.
     */
    func setupInitialViewController(){
        
        var mode :InitialViewControllerMode = .withoutSideMenu
        
        let walkthroughScreen = UIViewController.getViewController(WalkThroughPageViewController.self, storyboard: UIStoryboard.Storyboard.Walkthrough.object)
        var appHome : UIViewController!
//   if OAuthManager.shared.oauthswift.client.credential.oauthTokenSecret != ""
//   {
    appHome = UIViewController.getViewController(HomeViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
//   }
//        else
//   {
//    appHome = UIViewController.getViewController(LoginViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
//        }
        
        
        let sideMenuVC = UIViewController.getViewController(viewController: SideMenuViewController.self)
        
        var navigationController: UINavigationController?
        
        if checkKeyInUserDefault(key: AppConstants.UserDefaultKeys.IS_ALREADY_VISITED)
        {
            mode = .withSideMenu
            navigationController = UINavigationController(rootViewController: appHome)
        }
        else{
            mode = .withoutSideMenu
       
            navigationController = UINavigationController(rootViewController: walkthroughScreen)
   
        }
                 navigationController?.navigationBar.barTintColor = UIColor.appThemeColor()
        //Show with side menu or not
        if (mode == .withSideMenu){
            let sideMenuController = LGSideMenuController(rootViewController: navigationController, leftViewController: sideMenuVC, rightViewController:nil )
            sideMenuController.isLeftViewSwipeGestureEnabled = true
            sideMenuController.leftViewWidth = ScreenSize.size.width
            sideMenuController.leftViewLayerShadowColor = .clear
            sideMenuController.leftViewPresentationStyle = .slideAbove
            AppDelegate.sharedInstance.kMainViewController = sideMenuController
            AppDelegate.sharedInstance.window?.rootViewController = sideMenuController
            
        }else{
            AppDelegate.sharedInstance.window?.rootViewController = navigationController
        }
        
        
        AppDelegate.sharedInstance.window?.makeKeyAndVisible()
    }
    /**
     * This method is used for checking particular in User Default
     * parameter : String Object
     * @returns  : Bool
     */
    
    fileprivate func checkKeyInUserDefault(key:String) -> Bool {
        if(UserDefaultUtility.retrieveBoolForKey(key) == true) {
            
            if (UserDefaultUtility.objectAlreadyExist(key) == true){
                return true
            }
            return false
        }
        return false
    }
}
