
//Notes:- This class will be used as error transformers

import Foundation

class ErrorTransformer {
    
    class func getErrorModel(fromErrorObject errorObject:Any?,errorResponse: Error ,errorResolver:ErrorResolver)->ErrorModel {
        
        let errorModel = ErrorModel()
        if let errorResponseObj = errorObject as? ErrorResponse {
            errorModel.setErrorMessage(errorResponseObj.error?.message?.localized() ?? "Some error occured")
            errorModel.setErrorTitle(AppConstants.ErrorMessages.ALERT_TITLE)
            errorModel.setErrorPayloadInfo(errorResponseObj.dictionaryRepresentation())
        }else{
            if let mesage = ErrorTransformer.errorMessageForUnknownError(((errorResponse as NSError).code))
            {
                errorModel.setErrorMessage(mesage)
            }
            errorModel.setErrorTitle(AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
            errorModel.setErrorTitle(AppConstants.ErrorMessages.ALERT_TITLE)
        }
        return errorModel
    }
    class func errorMessageForUnknownError(_ errorResponseCode : Int)->String?
    {
        switch errorResponseCode {
        case -1001:
            return AppConstants.ErrorMessages.REQUEST_TIME_OUT
        case -1200:
            return AppConstants.ErrorMessages.REQUEST_TIME_OUT
        case -1005: fallthrough
        case -1009:
            return AppConstants.ErrorMessages.PLEASE_CHECK_YOUR_INTERNET_CONNECTION
        default:
            return nil
            
        }
    }
}
