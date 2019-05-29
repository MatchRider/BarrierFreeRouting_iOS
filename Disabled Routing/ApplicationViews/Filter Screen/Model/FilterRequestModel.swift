//
//  FilterRequestModel
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import AEXML
class FilterRequestModel {

    //MARK:- InformationRequestModel properties
    
    //Note :- Property Name must be same as key used in request API
    var requestBody: [String:AnyObject]!
    var requestHeader: [String:AnyObject]!
    init(builderObject builder:Builder){
        //Instantiating service Request model Properties with Builder Object property
        self.requestBody = builder.requestBody
        self.requestHeader = builder.requestHeader
    }
    
    // This inner class is used for setting upper class properties
    internal class Builder{
        //MARK:- Builder class Properties
        //Note :- Property Name must be same as key used in request API
        var requestBody: [String:AnyObject] = [String:AnyObject]()
        var requestHeader: [String:AnyObject] = [String:AnyObject]()
        /**
         This method is used for adding request Header
         
         - parameter key:   Key of a Header
         - parameter value: Value corresponding to header
         
         - returns: returning Builder object
         */
        
        func addRequestHeader(key:String , value:String) -> Builder {
            self.requestHeader[key] = value as AnyObject?
            return self
        }
        /**
         This method is used for set XML input model
         
         - parameter xml: Input XML String
         - returns: returning Builder Object
         */
        func setXMLRequest(_ xml:String) -> Builder{
            requestBody["xml"] = xml as AnyObject
            return self
        }
        /**
         This method is used to set properties in upper class of InformationRequestModel
         and provide InformationRequestModel object.
         
         -returns : InformationRequestModel
         */
        func build()->FilterRequestModel{
            return FilterRequestModel(builderObject: self)
        }
    }
    
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getEndPoint()->String{
        return AppConstants.ApiEndPoints.OSM_UPDATE_WAY
    }
}
