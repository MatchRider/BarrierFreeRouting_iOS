//
//  MapScreenViewDelgate.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation

//Notes:- This protocol is used as a interface which is used by MapScreenViewPresenter to tranfer info to MapScreenViewController

protocol MapScreenViewDelgate: BaseViewProtocol{
    func didReceiveNodes(withResponseModel directionsResponseModel:NodesResponseModel)
     func didReceiveWayInfo(withResponseModel wayInofResponseModel:WayResponseModel)
    func didReceiveDirections(withResponseModel directionsResponseModel:DirectionResponseModel)
     func didUpdateWay(withResponseModel updateResponseModel:UpdateResponseModel)
}

protocol PlacesViewDelegate:BaseViewProtocol
{
    func didReceivePlacesSuggestion(withResponseModel directionsResponseModel:PlacesResponseModel)
    func didReceiveAddress(withResponseModel directionsResponseModel:PlacesResponseModel)
}
