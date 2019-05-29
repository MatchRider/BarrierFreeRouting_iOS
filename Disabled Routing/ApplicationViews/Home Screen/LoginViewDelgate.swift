//
//  LoginViewDelgate.swift
//  Wapanda
//
//  Created by Daffomac-23 on 7/19/17.
//  Copyright © 2017 Wapanda. All rights reserved.
//

import Foundation

//Notes:- This protocol is used as a interface which is used by LoginViewPresenter to tranfer info to LoginViewController

protocol LoginViewDelegate: BaseViewProtocol{
    
   func loginSuccessfull(withResponseModel loginResponseModel:LoginResponseModel)
}

//Notes:- This protocol is used as a delegate for Text Field validation

protocol TextFieldValidationDelegate:class {
    
    func showErrorMessage(withMessage message: String,forTextFields: TextFieldsType)
}
