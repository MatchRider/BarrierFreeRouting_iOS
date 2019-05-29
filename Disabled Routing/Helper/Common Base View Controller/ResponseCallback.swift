
//Note :- This method is used for Handling Api Response

import ObjectMapper
import EVReflection
protocol ResponseCallback:class {
    func servicesManagerSuccessResponseXML<T>(responseObject : T)
    func servicesManagerSuccessResponse<T:Mappable>(responseObject : T)
    func servicesManagerError(error : AnyObject)
}
extension ResponseCallback { func servicesManagerSuccessResponseXML<T>(responseObject : T){}}

