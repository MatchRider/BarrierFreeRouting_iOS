
//Note :- This Class is used for Direction Service means it is used for handling Directions Api

import UIKit
import EVReflection
class MapAPIRequest: ApiRequestProtocol {

    //MARK:- local properties
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    /**
     This method is used make an api request to service manager
     
     - parameter reqFromData: MapRequestModel which contains Request header and request body for the Get Directions api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequest(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.BASE_URL+reqFromData.getEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
         ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: DirectionResponseModel.self)
    }
    /**
     This method is used make an api request to service manager
     
     - parameter reqFromData: MapRequestModel which contains Request header and request body for the Get Directions api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForWays(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL+reqFromData.getWaysEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURLXML(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: EVObject.self)
    }
    /**
     This method is used make an api request to service manager
     
     - parameter reqFromData: MapRequestModel which contains Request header and request body for the Get Directions api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForPlaces(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.BASE_URL+reqFromData.getPlacesEndPoint(reqFromData.type)
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: PlacesResponseModel.self)
    }
    /**
     This method is used make an api request to service manager
     
     - parameter reqFromData: MapRequestModel which contains Request header and request body for the Get Directions api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForNodes(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.WHEEL_MAP_BASE_URL+reqFromData.getNodesEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: NodesResponseModel.self)
    }
    func makeAPIRequestForWayInformation(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getWayInfoEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPOSTWithURL(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: WayResponseModel.self)
    }
    func makeAPIRequestForWayUpdateInformation(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getWayUpdateInfoEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPOSTWithURL(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: UpdateResponseModel.self)
    }
    func makeAPIRequestForWayValidation(withReqFormData reqFromData: MapRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getWayValidateInfoEndPoint()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPOSTWithURL(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: UpdateResponseModel.self)
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
