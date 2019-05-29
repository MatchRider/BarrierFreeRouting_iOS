

import UIKit
import EVReflection
class CorrectionOptionAPIRequest: ApiRequestProtocol {

    //MARK:- local properties
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    /**
     This method is used make an api request to service manager to update element on the OSM server.
     
     - parameter reqFromData: CorrectionOptionRequestModel which contains Request header and request body for the Element update api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequest(withReqFormData reqFromData: CorrectionOptionRequestModel, responseCallback: ResponseCallback) {
        if reqFromData.elementType == .way {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPointForWayUpdateOnOSM(withWayId: reqFromData.requestBody["wayId"] as! String)
        } else {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPointForNodeUpdateOnOSM(withWayId: reqFromData.requestBody["nodeId"] as! String)
        }
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        ServiceManager.sharedInstance.requestPUTWithURLXML(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: EVObject.self)
    }
    
    /**
     This method is used make an api request to service manager to create element on the OSM Server.
     
     - parameter reqFromData: CorrectionOptionRequestModel which contains Request header and request body for the Element PUT api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeCreateElementAPIRequest(withReqFormData reqFromData: CorrectionOptionRequestModel, responseCallback: ResponseCallback) {
        
        if reqFromData.elementType == .way {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPointForWayCreateOnOSM()
        } else {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPointForNodeCreateOnOSM()
        }

        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPUTWithURLXML(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: EVObject.self)
    }
    
    /**
     This method is used make an api request to service manager to update element on the App Server.
     
     - parameter reqFromData: CorrectionOptionRequestModel which contains Request header and request body for the Element update api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForElementUpdateInformation(withReqFormData reqFromData: CorrectionOptionRequestModel, responseCallback: ResponseCallback) {
        
        if reqFromData.elementType == .way {
            self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getEndPointForWayUpdateOnServer()
        } else {
            self.apiRequestUrl = AppConstants.URL.DISABLED_ROUTING_BASE_URL+reqFromData.getEndPointForNodeUpdateOnServer()
        }
       
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPOSTWithURL(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: WayResponseModel.self)
    }
    
    /**
     This method is used make an api request to service manager to get element from OSM Server.
     
     - parameter reqFromData: CorrectionOptionRequestModel which contains Request header and request body for the Element GET api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForGetWayData(withReqFormData reqFromData: CorrectionOptionRequestModel, responseCallback: ResponseCallback) {
        
        if reqFromData.elementType == .way {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL+reqFromData.getEndPointForWayUpdateOnOSM(withWayId: reqFromData.requestBody["wayId"] as! String)
        } else {
            self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL+reqFromData.getEndPointForNodeUpdateOnOSM(withWayId: reqFromData.requestBody["nodeId"] as! String)
        }
        
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestGETWithURLXML(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: OSMElement.self)
    }
    /**
     This method is used make an api request to service manager to create a ChangeSet ID on the OSM Server
     
     - parameter reqFromData: CaptureOptionRequestModel which contains Request header and request body for the ChangeSet PUT api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequestForCreateChangeRequest(withReqFormData reqFromData: CorrectionOptionRequestModel, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPointForCreateChangeSet()
        
        let responseWrapper = ResponseWrapper(responseCallBack: responseCallback)
        
        ServiceManager.sharedInstance.requestPUTWithURLXML(self.apiRequestUrl, andRequestDictionary: reqFromData.requestBody, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: EVObject.self)
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
