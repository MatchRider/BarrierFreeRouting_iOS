
import Foundation
import ObjectMapper
import EVReflection
protocol ApiResponseReceiver{
    func onSuccess<T: Mappable>(_ response:T) -> Void
    func onSuccessXML<T>(_ response:T) -> Void
    func onError(errorObject:AnyObject?) -> Void
}
extension ApiResponseReceiver { func onSuccessXML<T>(_ response:T) -> Void {} }

class ResponseWrapper : ApiResponseReceiver  {
    
    let delegate         : ResponseCallback!
    init(responseCallBack:ResponseCallback){
        self.delegate = responseCallBack
    }
    
    /**
     This method is used for handling Success response of an API
     
     - parameter response: Response is a kind of Generic Object
     */
    
    func onSuccess<T:Mappable>(_ response:T) -> Void {
        self.delegate.servicesManagerSuccessResponse(responseObject: response)
    }
    
    /**
     This method is used for handling Success response of an API
     
     - parameter response: Response is a kind of Generic Object
     */
    
    func onSuccessXML<T>(_ response:T) -> Void {
        self.delegate.servicesManagerSuccessResponseXML(responseObject: response)
    }
    
    /**
     This method is used for handling Error response of an API
     
     - parameter errorResponse: NSError Object contains error info
     */
    
    func onError(errorObject: AnyObject?) ->Void {

        self.delegate.servicesManagerError(error : errorObject!)
    }
    
}

