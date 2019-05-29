//
//  LoginViewDelgate.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import EVReflection
//Notes:- This protocol is used as a interface which is used by CaptureOptionScreenViewPresenter to tranfer info to CaptureOptionScreenViewController

protocol LoginViewDelgate: BaseViewProtocol{
    func didReceiveUserDetails(withResponseModel userResponseModel:OSMUser)
    func loginSuccessful()
    func loginFailed()
}

