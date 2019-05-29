//
//  ViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 07/02/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import JHTAlertController

class HomeViewController: BaseViewController {
    @IBOutlet weak var buttonRoutePlanner: CustomButton!
    @IBOutlet weak var buttonSuggestion: CustomButton!
    
    var isOSMOptionTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.getWayData),
                                               name:  AppConstants.NSNotificationNames.INTERNET_RECHABLE_NOTIFICATION,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.getSurveyWayData),
                                               name:  AppConstants.NSNotificationNames.GET_SURVEY_WAY_NOTIFICATION,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.getOSMWayData),
                                               name:  AppConstants.NSNotificationNames.GET_OSM_WAY_NOTIFICATION,
                                               object: nil)
         LocationServiceManager.sharedInstance.checkForUserPermissions()
        self.setUpInitialView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.hideLoader(self)
        self.showNavigationBar()
        self.customizeNavigationBarWithTitle(navigationTitle:"", color: UIColor.appThemeColor(),isTranslucent:false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if isMovingToParent {
            NotificationCenter.default.removeObserver(self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc private func getWayData() {
        getSurveyWayData()
        getOSMWayData()
    }
    @objc private func getSurveyWayData() {
        WayDetails.shared.getWayData()
    }
    @objc private func getOSMWayData() {
        WayDetails.shared.getOSMData()
    }
    @IBAction func routeButtonTapped(_ sender: CustomButton) {
        self.naviagteToRouteScreen()
    }
    @IBAction func oSMButtonTapped(_ sender: CustomButton) {
        self.isOSMOptionTapped = true
        if !UserDefaultUtility.retrieveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN) {
            self.showLoginViewController()
        } else {
            self.naviagteToSuggestionScreen()
        }
    }
    @IBAction func suggestionButtonTapped(_ sender: Any) {
              self.isOSMOptionTapped = false
//        let alertController = JHTAlertController(
//
//            title: AppConstants.ScreenSpecificConstant.HomeScreen.ENHANCE_ROUTING_TEXT_LINE1,
//            message: AppConstants.ScreenSpecificConstant.HomeScreen.ENHANCE_ROUTING_TEXT_LINE2,
//            preferredStyle: .alert)
//        alertController.alertBackgroundColor = .white
//        alertController.titleViewBackgroundColor = .white
//
//        alertController.messageTextColor = .black
//        alertController.titleTextColor = .black
//
//        alertController.setAllButtonBackgroundColors(to: UIColor.appThemeColor())
//        alertController.hasRoundedCorners = false
//
//        alertController.titleFont = UIFont.getFrutigerBold(withSize: 20)
//        alertController.messageFont = UIFont.getFrutigerBold(withSize: 20)
//        let openAction = JHTAlertAction(title: AppConstants.ScreenSpecificConstant.Common.YES_TITLE, style: .default) { (action) in
//
//
//        }
//        alertController.addAction(openAction)
//
//        let cancelAction = JHTAlertAction(title: AppConstants.ScreenSpecificConstant.Common.NO_TITLE, style: .default) { (action) in
//            alertController.dismiss(animated: true, completion: nil)
//        }
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
        if !UserDefaultUtility.retrieveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN){
            self.showLoginViewController()
        }
        else {
            self.naviagteToSuggestionScreen()
        }
    }
    private func setUpInitialView() {
        self.addNavigationMenuButton()
        self.localizeView()
    }
    
    private func showLoginViewController() {
         let loginViewController = UIViewController.getViewController(LoginViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        loginViewController.delegate = self
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    private func naviagteToSuggestionScreen() {
        let locationFetchVC = UIViewController.getViewController(MapScreenViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        locationFetchVC.isFromSuggestionScreen = true
        locationFetchVC.isOSMData = self.isOSMOptionTapped
        self.navigationController?.pushViewController(locationFetchVC, animated: true)
    }
    private func naviagteToRouteScreen() {
        let mapScreenVC = UIViewController.getViewController(MapScreenViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        mapScreenVC.isRouteNavigation = true
        self.navigationController?.pushViewController(mapScreenVC, animated: true)
    }
    private func localizeView() {
    buttonSuggestion.setTitle(AppConstants.ScreenSpecificConstant.HomeScreen.SUGGESTION.localized(), for: .normal)
    buttonRoutePlanner.setTitle(AppConstants.ScreenSpecificConstant.HomeScreen.ROUTE_PLANNER.localized(), for: .normal)
    }
}
extension HomeViewController : LoginViewDelgate
{
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        
    }
    
    func didReceiveUserDetails(withResponseModel userResponseModel: OSMUser) {
        
    }
    
    func loginSuccessful() {
        self.naviagteToSuggestionScreen()
    }
    
    func loginFailed() {
        
    }
    
    
}
