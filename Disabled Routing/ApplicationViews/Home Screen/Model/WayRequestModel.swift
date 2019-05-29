//
//  WayRequestModel.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 7/19/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation


class WayRequestModel {
    
    //MARK:- WayRequestModel properties
    
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
         This method is used for setting userName
         
         - parameter userName: String parameter that is going to be set on userName
         
         - returns: returning Builder Object
         */
        func setUserName(_ userName:String)->Builder{
            requestBody["userName"] = userName as AnyObject?
            
            return self
        }
        
        
        /**
         This method is used for setting password
         
         - parameter password: String parameter that is going to be set on password
         
         - returns: returning Builder Object
         */
        func setPassword(_ password:String)->Builder{
            requestBody["password"] = password as AnyObject?
            return self
        }
        
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
         This method is used to set properties in upper class of WayRequestModel
         and provide WayRequestModel object.
         
         -returns : WayRequestModel
         */
        func build()->WayRequestModel{
            return WayRequestModel(builderObject: self)
        }
    }
    
    /**
     This method is used for getting way end point
     
     -returns: String containg end point
     */
    func getEndPoint()->String{
        return AppConstants.ApiEndPoints.WAY_LIST
    }
    func getOSMEndPoint()->String{
        return AppConstants.ApiEndPoints.OSM_DATA
    }
}
