
import UIKit
import EVReflection
class LoginAPIRequest: ApiRequestProtocol {
    
    //MARK:- local properties
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    /**
     This method is used make an api request to service manager to get information of User Details
     
     - parameter reqFromData: LoginRequestModel which contains Request header and request body for the user detail api call
     
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequest(withReqFormData reqFromData: LoginRequestModel, responseCallback: ResponseCallback) {
        self.apiRequestUrl = AppConstants.URL.OSM_BASE_URL + reqFromData.getEndPoint()
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
