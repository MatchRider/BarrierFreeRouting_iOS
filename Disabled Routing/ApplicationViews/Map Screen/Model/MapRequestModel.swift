//
//  MapRequestModel
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
class MapRequestModel {
    enum QueryType : Int{
        case query
        case location
    }
    //MARK:- MapRequestModel properties
    
    //Note :- Property Name must be same as key used in request API
    var requestBody: [String:AnyObject]!
    var requestHeader: [String:AnyObject]!
    
    var fromlat: Double!
    var fromlong: Double!
    var tolat: Double!
    var tolong: Double!
    var routeLat: Double!
    var routeLong: Double!
    var restrictions: String!
    var query: String!
    var wayId: String!
    var type: QueryType!
    init(builderObject builder:Builder){
        //Instantiating service Request model Properties with Builder Object property
        self.requestBody = builder.requestBody
        self.requestHeader = builder.requestHeader
        self.fromlat = builder.fromlat
        self.fromlong = builder.fromlong
        self.tolat = builder.tolat
        self.tolong = builder.tolong
        self.routeLat = builder.routelat
        self.routeLong = builder.routelong
        self.query = builder.query
        self.type = builder.type
        self.wayId = builder.wayId
        self.restrictions = builder.restrictions
    }
    
    // This inner class is used for setting upper class properties
    internal class Builder{
        //MARK:- Builder class Properties
        //Note :- Property Name must be same as key used in request API
        var requestBody: [String:AnyObject] = [String:AnyObject]()
        var requestHeader: [String:AnyObject] = [String:AnyObject]()
        var fromlat: Double!
        var fromlong: Double!
        var tolat: Double!
        var tolong: Double!
        var wayId: String!
        var routelat: Double!
        var routelong: Double!
        var query: String!
        var type: QueryType!
        var restrictions: String!
        /**
         This method is used for setting From Latitude
         
         - parameter fromLat: Double parameter
         - returns: returning Builder Object
         */
        func setFromLat(_ fromLat:Double) -> Builder{
            self.fromlat = fromLat
            return self
        }
        func setFromWayId(_ WayId:String) -> Builder{
            self.requestBody["WayId"] = WayId as AnyObject
            return self
        }
        func setWayData(_ waydata:[String:Any])-> Builder
        {
            self.requestBody["WayData"] = waydata as AnyObject
            return self
        }
        /**
         This method is used for setting From Latitude
         
         - parameter fromLat: Double parameter
         - returns: returning Builder Object
         */
        func setRestrictions(_ restrictions:String) -> Builder{
            self.restrictions = restrictions
            return self
        }
        /**
         This method is used for setting From Latitude
         
         - parameter fromLat: Double parameter
         - returns: returning Builder Object
         */
        func setQuery(_ query:String) -> Builder{
            self.query = query
            return self
        }
        /**
         This method is used for setting From Longitude
         
         - parameter fromLong: Double parameter
         - returns: returning Builder Object
         */
        func setFromLong(_ fromLong:Double) -> Builder{
            self.fromlong = fromLong
            return self
        }
        
        /**
         This method is used for setting To Latitude
         
         - parameter toLat: Double parameter
         
         - returns: returning Builder Object
         */
        func setToLat(_ toLat:Double) -> Builder{
            self.tolat = toLat
            return self
        }
        
        /**
         This method is used for setting To Latitude
         
         - parameter toLong: Double parameter
         
         - returns: returning Builder Object
         */
        func setToLong(_ toLong:Double) -> Builder{
            self.tolong = toLong
            return self
        }
        /**
         This method is used for setting Route Latitude
         
         - parameter toLat: Double parameter
         
         - returns: returning Builder Object
         */
        func setRouteLat(_ routeLat:Double) -> Builder{
            self.routelat = routeLat
            return self
        }
        
        /**
         This method is used for setting Route Latitude
         
         - parameter toLong: Double parameter
         
         - returns: returning Builder Object
         */
        func setRouteLong(_ routeLong:Double) -> Builder{
            self.routelong = routeLong
            return self
        }
        /**
         This method is used for setting Query Type
         
         - parameter fromLat: QueryType parameter
         - returns: returning Builder Object
         */
        func setQueryType(_ type:QueryType) -> Builder{
            self.type = type
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
         This method is used to set properties in upper class of MapRequestModel
         and provide MapRequestModel object.
         
         -returns : MapRequestModel
         */
        func build()->MapRequestModel{
            return MapRequestModel(builderObject: self)
        }
    }
    
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getEndPoint()->String{
        var coordinatePoints = String(format:"%f,%f|%f,%f",self.fromlong,self.fromlat,self.tolong,self.tolat)
        if let routeLat = self.routeLat,routeLat != 0.0
        {
            coordinatePoints = String(format:"%f,%f|%f,%f|%f,%f",self.fromlong,self.fromlat,self.routeLong,self.routeLat,self.tolong,self.tolat)
        }
        if let restriction = self.restrictions,restriction != ""
        {
            return String(format: AppConstants.ApiEndPoints.DIRECTIONS,coordinatePoints,self.restrictions)
        }
        else
        {
            return String(format: AppConstants.ApiEndPoints.DIRECTIONS_WITHOUT_FILTERS,coordinatePoints)
        }
    }
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getNodesEndPoint( )->String{
        return String(format: AppConstants.ApiEndPoints.GET_NODES,self.fromlong,self.fromlat,self.tolong,self.tolat)
    }
    func getWayInfoEndPoint( )->String{
        return String(format: AppConstants.ApiEndPoints.GET_WAY_INFO)
    }
    func getWayUpdateInfoEndPoint( )->String{
        return String(format: AppConstants.ApiEndPoints.UPDATE_WAY_INFO)
    }
    func getWayValidateInfoEndPoint( )->String{
        return String(format: AppConstants.ApiEndPoints.VALIDATE_WAY_INFO)
    }
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getWaysEndPoint( )->String{
        return String(format: AppConstants.ApiEndPoints.GET_NODES,self.fromlong,self.fromlat,self.tolong,self.tolat)
    }
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getPlacesEndPoint(_ type:QueryType)->String{
        var param = ""
        if type == .query
        {
            param = "text=\((self.query)!)"
            return String(format: AppConstants.ApiEndPoints.GEOCODING,param)
        }
        else
        {
            param = "\((self.query)!)"
            return String(format: AppConstants.ApiEndPoints.REVERSE_GEOCODING,param)
        }
        
    }
}
