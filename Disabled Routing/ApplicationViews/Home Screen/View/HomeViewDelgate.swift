//
//  LoginViewDelgate.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 7/19/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation

//Notes:- This protocol is used as a interface which is used by LoginViewPresenter to tranfer info to LoginViewController

protocol WayViewDelegate: BaseViewProtocol{
    
    func receivedWayDataSuccessfully(withResponseModel wayDataResponseModel:WayResponseModel)
    func receivedOSMServerDataSuccessfully(withResponseModel osmResponseModel:WayResponseModel,andNodeReferences nodeReferences:[NodeReference])
}
