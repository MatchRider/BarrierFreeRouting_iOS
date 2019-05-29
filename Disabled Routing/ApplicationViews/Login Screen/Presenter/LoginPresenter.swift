//
//  LoginPresenter.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import EVReflection
import AEXML
class LoginPresenter: ResponseCallback{
    
    //MARK:- LoginPresenter local properties
    private weak var loginDelegate             : LoginViewDelgate?
    private var shouldShowLoaderOnScreen = true
    //MARK:- Constructor
    init(delegate responseDelegate:LoginViewDelgate) {
        self.loginDelegate = responseDelegate
    }

    //MARK:- ResponseCallback delegate methods
    
    func servicesManagerSuccessResponse<T:Mappable> (responseObject : T){
        self.loginDelegate?.hideLoader()
    }
    func servicesManagerSuccessResponseXML<T>(responseObject: T) {
        self.loginDelegate?.hideLoader()
    
            if let elementData = OSMUser(xmlData: responseObject as? Data) {
            self.loginDelegate?.didReceiveUserDetails(withResponseModel: elementData)
            }
    }
    func servicesManagerError(error : AnyObject){
        self.loginDelegate?.hideLoader()
        if let errorData = error as? Data,let errorMessage = String(data: errorData, encoding: String.Encoding.utf8)
        {
            self.loginDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: errorMessage)
        }
    }
    
    
    //MARK:- Methods to call server
    

    //MARK:- Methods to call server
    
    /**
     This method is used to send create node request to business layer with valid Request model
     - returns : Void
     */
    func sendGetUserDetailsRequest() -> Void{
        self.loginDelegate?.showLoader()
        let loginRequestModel : LoginRequestModel = LoginRequestModel.Builder().build()
        LoginAPIRequest().makeAPIRequest(withReqFormData: loginRequestModel, responseCallback: self)
    }
}

