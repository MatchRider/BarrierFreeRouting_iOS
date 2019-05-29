
import UIKit
import MBProgressHUD
import SwiftKeychainWrapper
class BaseViewController: UIViewController  {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    let bgView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.internetRechableNotification), name: NSNotification.Name(rawValue: AppConstants.NSNotificationNames.INTERNET_RECHABLE_NOTIFICATION), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.internetUnreachableNotification), name: NSNotification.Name(rawValue: AppConstants.NSNotificationNames.INTERNET_UNREACHABLE_NOTIFICATION), object: nil)
        
        bgView.frame =  CGRect(x: 0, y: 0, width: ScreenSize.size.width, height: ScreenSize.size.height)
        bgView.backgroundColor = UIColor.darkGray
        bgView.alpha = 0.5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func internetRechableNotification(){
//        if let vc = UIApplication.shared.visibleViewController as? NoInternetViewController{
//           vc.dismiss(animated: true, completion: nil)
//            self.setInternetViewDismissed()
//        }
    }
    
    func setInternetViewDismissed(){
        //self.noInternetVC = nil
    }
    
    
    func internetUnreachableNotification(){
//        if let _ = UIApplication.shared.visibleViewController as? NoInternetViewController{
//        }
//        else{
//        noInternetVC = UIViewController.getViewController(NoInternetViewController.self,storyboard: UIStoryboard.Storyboard.Main.object)
//        UIApplication.shared.visibleViewController?.present(noInternetVC!, animated: true, completion: nil)
//        }
    }
    
    /**
     This Method is used for showing loader
     
     - parameter VC: This object contains ViewController Object reference
     */
    
    func showLoader(_ VC : AnyObject?){
        
        let topMostController = VC
    
        self.view.addSubview(self.bgView)

        DispatchQueue.main.async(execute: {
          
            MBProgressHUD.showAdded(to: (VC?.view)!, animated: true)
        })
       // UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /**
     This Method is used for hiding loader
     
     - parameter VC: This object contains ViewController Object reference
     */
    
    
    func hideLoader(_ VC : AnyObject?){
        
        self.bgView.removeFromSuperview()

        
//        if(UIApplication.shared.isIgnoringInteractionEvents == true){
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
        DispatchQueue.main.async(execute: {
          MBProgressHUD.hide(for: VC!.view, animated: true)
        })
    }
    
    /**
     This Method is used for showing Error Alert
     
     - parameter alertTitle:   This parameter contain Alert Title
     - parameter alertMessage: This parameter contain Alert Message that need to be shown
     - parameter VC:           ViewConroller On Which we have to show error alert
     */
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String,VC : AnyObject?){
        
      
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: alertTitle , message:
                alertMessage, preferredStyle: .alert)
           
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            
            VC!.present(alertController, animated: true, completion: nil)
            
        }
        else {
            let alertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
            alertView.show()
        }
        
    }
    
    
    /**
     Show error Alert with cancel and Confirm button and callback
     
     - parameter alertTitle:   This parameter contain Alert Title
     - parameter alertMessage: This parameter contain Alert Message that need to be shown
     - parameter VC:           ViewConroller On Which we have to show error alert

     -returns : Void
     */
    func showErrorAlertWithCancelAndConfirmButtons(_ alertTitle: String, alertMessage: String,VC : AnyObject?){
        
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: alertTitle , message:
                alertMessage, preferredStyle: .alert)
           
            alertController.addAction(UIAlertAction(title: "No", style: .default,handler:  { Void in
            }))
            alertController.addAction(UIAlertAction(title: "Yes", style: .default,handler: { Void in
                self.errorAlertConfirmButtonClicked()
            }))

            VC!.present(alertController, animated: true, completion: nil)
        }
    }
    
    

    func showErrorAlertForLogout(_ alertTitle: String, alertMessage: String,VC : AnyObject?){
        
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: alertTitle , message:
                alertMessage, preferredStyle: .alert)
           
            alertController.addAction(UIAlertAction(title: "Ok", style: .default,handler:  { Void in
                self.logOutUser()
            }))
            VC!.present(alertController, animated: true, completion: nil)
        }
    }
    /**
     This Method is used for showing Error Alert with click handler
     
     - parameter alertTitle:   This parameter contain Alert Title
     - parameter alertMessage: This parameter contain Alert Message that need to be shown
     - parameter VC:           ViewConroller On Which we have to show error alert
     
     -returns : Void
     */
    
    func showErrorAlertWithHandler(_ alertTitle: String, alertMessage: String,VC : AnyObject?, clickHandler: @escaping () -> Void){
        
        if #available(iOS 8, *) {
            let alertController = UIAlertController(title: alertTitle , message:
                alertMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler:  { Void in
                clickHandler()
//                self.dismiss(animated: true, completion: nil)
            }))
            VC!.present(alertController, animated: true, completion: nil)
        }
    }
    func showErrorWithActions(alertTitle : String,alertMessage : String,VC:AnyObject?,yestitle:String,noTitle:String,yesHandler:(()->Void)?,noHandler:(()->Void)?)
    {
        let alertController = UIAlertController(title: alertTitle , message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: yestitle, style: .default,handler:  { Void in
            yesHandler?()
        }))
        alertController.addAction(UIAlertAction(title: noTitle, style: .cancel,handler:  { Void in
            noHandler?()
        }))
        VC!.present(alertController, animated: true, completion: nil)
    }
    
    func errorAlertConfirmButtonClicked(){
        
    }
    
    func errorAlertHandler(){
       self.dismiss(animated: true, completion: nil)
    }

    func navigatedToSpecifiedController<T:UIViewController>(viewController ofType:T.Type,storyboard:UIStoryboard)
    {
        var popped=false;
        let toViewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
        
        if let _ =  self.navigationController
        {
            for viewController in ((self.navigationController)?.viewControllers)!
            {
                if viewController.isKind(of: T.self)
                {
                    popped=true;
                    (self.navigationController)?.popToViewController(viewController, animated: true)
                    break
                }
            }
            
            if !popped {
                (self.navigationController)?.pushViewController(toViewController,animated:true);
            }
        }
        else
        {
            
            (self.navigationController)?.pushViewController(toViewController,animated:true);
        }
    }
    func getImageURL(_ imageId:String)->URL
    {
        return URL(string: "\(AppConstants.URL.BASE_URL)/files/\(imageId)?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)")!
    }
     func readJson(_ fileName:String) -> [String: Any] {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return [:]
    }
    //MARK: Log out functionality
    
    /// This method is used to direct direct the user to Login screen if he perform any opera
     func logOutUser()
    {
        UserDefaultUtility.removeStringWithKey(AppConstants.UserDefaultKeys.OAUTH_TOKEN)
        UserDefaultUtility.removeStringWithKey(AppConstants.UserDefaultKeys.OAUTH_TOKEN_SECRET)
        UserDefaultUtility.saveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN, value: false)
        OAuthManager.shared.oauthswift.client.credential.oauthTokenSecret = ""
        OAuthManager.shared.oauthswift.client.credential.oauthToken = ""
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: AppConstants.UserDefaultKeys.USER_ID)
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: AppConstants.UserDefaultKeys.USER_NAME)

        NotificationCenter.default.post(name: AppConstants.NSNotificationNames.USER_LOG_OUT_NOTIFICATION, object: nil)
        
        AppInitialViewHandler.sharedInstance.setupInitialViewController()
        
//        self.navigatedToSpecifiedController(viewController: LoginViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func logout(){
        
       
        let alertController = UIAlertController(title: AppConstants.ScreenSpecificConstant.Common.LOGOUT_TITLE , message:
            AppConstants.ScreenSpecificConstant.Common.LOGOUT_MESSAGE, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AppConstants.ScreenSpecificConstant.Common.NO_TITLE, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: AppConstants.ScreenSpecificConstant.Common.YES_TITLE, style: .default, handler: { (alertAction) in
            self.logOutUser()
            
        }))
        
        AppDelegate.sharedInstance.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }

    
    
     func registerDeviceToken()
    {
//        if UserDefaultUtility.objectAlreadyExist(AppConstants.UserDefaultKeys.DEVICE_TOKEN)
//        {
//            
//        }
    }
     func deRegisterDeviceToken()
    {
        
    }
    func initialseAlertController(withTitle title:String,andMessage message:String)->UIAlertController
    {
        let alertController = UIAlertController(title: title , message:
            message, preferredStyle: .alert)
    
        return alertController
    }
}

