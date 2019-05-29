//
//  LoginViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 11/06/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import OAuthSwift
import SwiftKeychainWrapper
class LoginViewController: BaseViewController {
    //IBOutlets
    @IBOutlet weak var buttonLogin: CustomButton!

    weak var delegate : LoginViewDelgate?
    var presenter : LoginPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonLogin.setTitle("LOGIN_WITH_OSM".localized(), for: .normal)
        self.presenter = LoginPresenter(delegate:self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.hideLoader(self)
    }
    
    /// Action method of login button to initiate OSM Auth Login.
    ///
    /// - Parameter sender: Custom Button
    @IBAction func loginButtonTapped(_ sender: CustomButton) {
       self.initiateOSMAuth()
    }
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initiateOSMAuth()
    {
         self.showLoader(self)
        var oauthswift = OAuth1Swift(
            consumerKey     :       AppConstants.OAUTHSettings.CONSUMER_KEY,
            consumerSecret  :       AppConstants.OAUTHSettings.CONSUMER_SECRET,
            requestTokenUrl :       AppConstants.OAUTHSettings.REQUEST_TOKEN_URL,
            authorizeUrl    :       AppConstants.OAUTHSettings.AUTHORIZE_TOKEN_URL,
            accessTokenUrl  :       AppConstants.OAUTHSettings.ACCESS_TOKEN_URL
        )
        OAuthManager.shared.oauthswift = oauthswift
        OAuthManager.shared.oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: OAuthManager.shared.oauthswift)
     
        let _ =  OAuthManager.shared.oauthswift.authorize(
            withCallbackURL: URL(string: AppConstants.ScreenSpecificConstant.LoginScreen.OSM_CALL_BACK_URL)!,
            success: { credential, response, parameters in

                ///Save the Auth Token and Token Secret to check for user login in future.
                UserDefaultUtility.saveStringWithKey(credential.oauthToken, key: AppConstants.UserDefaultKeys.OAUTH_TOKEN)
                UserDefaultUtility.saveStringWithKey(credential.oauthTokenSecret, key: AppConstants.UserDefaultKeys.OAUTH_TOKEN_SECRET)
                UserDefaultUtility.saveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN, value: true)
                self.presenter.sendGetUserDetailsRequest()
                
                self.hideLoader(self)
              
              
        },
            failure: { error in
                UserDefaultUtility.saveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN, value: false)
                 self.delegate?.loginFailed()
                 self.hideLoader(self)
                self.dismiss(animated: true, completion: {})
                print(error.localizedDescription)
        }
        )
    }
}

extension LoginViewController : LoginViewDelgate
{
    func didReceiveUserDetails(withResponseModel userResponseModel: OSMUser) {
         KeychainWrapper.standard.set((userResponseModel.user?._id)!, forKey: AppConstants.UserDefaultKeys.USER_ID)
         KeychainWrapper.standard.set((userResponseModel.user?._display_name)!, forKey: AppConstants.UserDefaultKeys.USER_NAME)
        self.delegate?.loginSuccessful()
        self.dismiss(animated: true, completion: {})
    }
    
    func loginSuccessful() {
        
    }
    
    func loginFailed() {
        
    }
    
    func showLoader() {
        self.showLoader(self)
    }
    
    func hideLoader() {
        self.hideLoader(self)
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        self.showErrorAlert(alertTitle, alertMessage: alertMessage, VC: self)
    }
    
    
}
