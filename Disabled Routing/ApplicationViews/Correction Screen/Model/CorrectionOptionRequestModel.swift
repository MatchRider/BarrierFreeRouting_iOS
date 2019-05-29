//
//  CorrectionOptionRequestModel
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import AEXML
class CorrectionOptionRequestModel {

    //MARK:- CorrectionOptionRequestModel properties
    
    //Note :- Property Name must be same as key used in request API
    var requestBody: [String:AnyObject]!
    var requestHeader: [String:AnyObject]!
    var elementType : ElementType!
    init(builderObject builder:Builder){
        //Instantiating service Request model Properties with Builder Object property
        self.requestBody = builder.requestBody
        self.requestHeader = builder.requestHeader
         self.elementType = builder.elementType
    }
    
    // This inner class is used for setting upper class properties
    internal class Builder{
        //MARK:- Builder class Properties
        //Note :- Property Name must be same as key used in request API
        var requestBody: [String:AnyObject] = [String:AnyObject]()
        var requestHeader: [String:AnyObject] = [String:AnyObject]()
        var elementType:ElementType = .way
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
         This method is used for setting Query Type
         
         - parameter fromLat: QueryType parameter
         - returns: returning Builder Object
         */
        func setXMLRequest(_ xml:String) -> Builder{
            requestBody["xml"] = xml as AnyObject
            return self
        }
        func setWayId(_ wayId:String) -> Builder{
            requestBody["wayId"] = wayId as AnyObject
            return self
        }
        func setElementType(_ type:ElementType) -> Builder{
            elementType = type
            return self
        }
        func setNodeId(_ nodeId:String) -> Builder{
            requestBody["nodeId"] = nodeId as AnyObject
            return self
        }
        func setWayData(_ wayData:[String:Any]) -> Builder{
            requestBody["WayData"] = wayData as AnyObject
            return self
        }
        func setNodeData(_ nodeData:[String:Any]) -> Builder{
            requestBody["NodeData"] = nodeData as AnyObject
            return self
        }
        func setUserData(_ userData:String) -> Builder{
            requestBody["ModifiedByUser"] = userData as AnyObject
            return self
        }
        /**
         This method is used to set properties in upper class of CorrectionOptionRequestModel
         and provide CorrectionOptionRequestModel object.
         
         -returns : CorrectionOptionRequestModel
         */
        func build()->CorrectionOptionRequestModel{
            return CorrectionOptionRequestModel(builderObject: self)
        }
    }
    
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getEndPointForCreateChangeSet()->String{
        return AppConstants.ApiEndPoints.OSM_CREATE_CHANGE_SET
    }
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getEndPointForWayUpdateOnOSM(withWayId id:String)->String{
        return String(format:AppConstants.ApiEndPoints.OSM_UPDATE_WAY,id)
    }
    
    func getEndPointForNodeUpdateOnOSM(withWayId id:String)->String{
        return String(format:AppConstants.ApiEndPoints.OSM_UPDATE_NODE,id)
    }
    func getEndPointForWayCreateOnOSM()->String{
        return String(format:AppConstants.ApiEndPoints.OSM_CREATE_WAY)
    }
    
    func getEndPointForNodeCreateOnOSM()->String{
        return String(format:AppConstants.ApiEndPoints.OSM_CREATE_NODE)
    }
    /**
     This method is used for getting directions end point
     
     -returns: String containg end point
     */
    func getEndPointForWayUpdateOnServer()->String{
         return AppConstants.ApiEndPoints.UPDATE_WAY_INFO
    }
    
    func getEndPointForNodeUpdateOnServer()->String{
        return AppConstants.ApiEndPoints.UPDATE_NODE_INFO
    }
}
