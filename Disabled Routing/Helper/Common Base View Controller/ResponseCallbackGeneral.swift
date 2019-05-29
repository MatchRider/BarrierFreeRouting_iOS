
//Note :- This method is used for Handling Api Response

import ObjectMapper
import EVReflection
protocol ResponseCallbackGeneral:class {
    func servicesManagerSuccessResponse<T:AnyObject>(responseObject : T)
    func servicesManagerSuccessResponseXML<T>(responseObject : T)
    func servicesManagerError(error : AnyObject?)
}

