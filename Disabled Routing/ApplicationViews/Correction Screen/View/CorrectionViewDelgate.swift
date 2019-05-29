//
//  CorrectionViewDelgate.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import EVReflection
import AEXML
//Notes:- This protocol is used as a interface which is used by CaptureOptionScreenViewPresenter to tranfer info to CaptureOptionScreenViewController

protocol CorrectionViewDelgate: BaseViewProtocol{
    func didCreatedChangeSet(withResponseModel changeSetResponseModel:String)
    func didUpdateWayDataOSM(forType type:ElementType,andResponseModel changeSetResponseModel:String)
    func didGetDataOSM(withResponseModel osmData:OSM,andXMLData xmlData:AEXMLDocument)
   // func didCreateWayOSM(withResponseModel changeSetResponseModel:String)
   // func didCreateNodeOSM(withResponseModel changeSetResponseModel:String)
    func didUpdateElementDataOnServer(withResponseModel changeSetResponseModel:WayResponseModel)
}

