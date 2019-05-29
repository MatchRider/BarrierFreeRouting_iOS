/**
 This class handle all the setup work on project launch
 */


import Foundation
import IQKeyboardManager
import Alamofire
import Localize_Swift
class AppLaunchSetup: NSObject {
    
    /*
     Create Singleton object for the class
     */
    static let shareInstance = AppLaunchSetup()
    
    private override init() {
        
    }
    
    /**
     This method is used to enable network rechability monitoring
     */
    func startMonitoringNetworkRechability(){
       
    }
    /**
     This method is used to enable IQKeyabord
     */
    func setupIQKeyboard(){
        IQKeyboardManager.shared().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.shared().isEnabled = true
    }
    
    /**
     This methods is used to set up default language for the environment
    */
    func setUpDefaultLanguage()
    {
        Localize.setCurrentLanguage(AppConstants.AppLanguages.DEFAULT_LANGUAGE)
    }
}
