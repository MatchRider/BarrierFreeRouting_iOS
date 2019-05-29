//
//  InformationScreenRequestModel.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 20/03/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
struct FilterScreenRequestModel
{
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var changeSetId : String?
    var surfaceType : String?
    var highway  : String?
    var smoothness  : String?
    var slopedCurb  : String?
    var incline  : String?
    var width  : String?
    var slopedCurbValue  : String?
    var inclineValue  : String?
    var widthValue  : String?
    var surfaceTypeValue : String?
    var obstacle  : String?
    var routeViaInfo : (lat:Double,long:Double,address:String) = (0.0,0.0,"")
    var sourceInfo : (lat:Double?,long:Double?,address:String?)
    var destinationInfo : (lat:Double?,long:Double?,address:String?)
    
    var isFilterApplied = false
}
