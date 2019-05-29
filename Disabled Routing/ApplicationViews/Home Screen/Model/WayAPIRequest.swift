//
//  WayAPIRequest.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 7/19/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import EVReflection
class WayAPIRequest:ApiRequestProtocol {
    
    //MARK:- local properties
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    /**
     This method is used make an api request to service manager to get Survey Way Data.
     - parameter reqFromData: WayRequestModel which contains Request header and request body for the way api call
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequest(withReqFormData reqFromData: WayRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: WayResponseModel.self)
    }
    
    /**
     This method is used make an api request to service manager to get OSM Way Data from OSM Server.
     - parameter reqFromData: WayRequestModel which contains Request header and request body for the way api call
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForOSMRequest(withReqFormData reqFromData: WayRequestModel, responseCallback: ResponseCallback) {
       
        self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL+reqFromData.getOSMEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURLXML(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: EVObject.self)
    }
    /**
     This method is used to know that whether the api request is in progress or not
     
     - returns: Boolean value either true or false
     */
    func isInProgress() -> Bool {
        return true
    }
    
    /**
     This method is used to cancel the particular API request
     */
    func cancel() -> Void{
        ServiceManager.sharedInstance.cancelTaskWithURL(self.apiRequestUrl)
    }
}
