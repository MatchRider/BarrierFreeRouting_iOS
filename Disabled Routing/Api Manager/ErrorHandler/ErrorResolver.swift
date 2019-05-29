
/// Error Resolver class is used for resolving Error Issue

class ErrorResolver {

    fileprivate var errorDict: [String: String] = [String: String]()

    /**
     This method is used for registering error code for specific APIs
     
     - parameter errorCode: Code of Error
     - parameter message:   Message string corresponding to error
     */

    func registerErrorCode(_ errorCode: ErrorCodes, message: String){
        
        //Mapping messages corresponding to specific code
        self.errorDict["\(errorCode.rawValue)"] = message
    }
    
     /**
     This method is used for sending specific error message corresponding to error code
     
     - parameter errorCode: Error Code corresponding to specific error
     
     - returns: Returning Error Message
     */
    
    func getErrorObjectForCode(_ errorCode: String) -> String
    {
        //This line check whether error is resolvable or not
        
        if isErrorResolvable(errorCode){
            
            return errorDict[errorCode]!
        }
        else{
           return AppConstants.ErrorMessages.SOME_ERROR_OCCURED
        }
    }
    
    /**
     This method is used for checking whether error is already added or not in Error Dictionary
     
     - parameter code: Error Code
     
     - returns: Returning True or false
     */
    
    fileprivate func isErrorResolvable(_ code: String) -> Bool
    {
        guard let _ = errorDict[code] else {
            return false
        }
        return true
    }
    /**
     This method is used for adding set of Predefined Error coming from server
     */
    class func registerErrorsForApiRequests() ->ErrorResolver{
        
        let errorResolver:ErrorResolver = ErrorResolver()
        
//        errorResolver.registerErrorCode(ErrorCodes.INTERNAL_ERROR, message  : AppConstants.ErrorMessages.INTERNAL_ERROR)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_INPUT, message  : AppConstants.ErrorMessages.INVALID_INPUT)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_OTP, message  : AppConstants.ErrorMessages.INVALID_OTP)
//        errorResolver.registerErrorCode(ErrorCodes.UNAUTHORIZED, message  : AppConstants.ErrorMessages.UNAUTHORIZED)
//        errorResolver.registerErrorCode(ErrorCodes.ACCESS_DENIED, message  : AppConstants.ErrorMessages.ACCESS_DENIED)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_LOGIN, message  : AppConstants.ErrorMessages.INVALID_LOGIN_MESSAGE)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_AUTH, message  : AppConstants.ErrorMessages.INVALID_AUTH)
//        errorResolver.registerErrorCode(ErrorCodes.NOT_FOUND, message  : AppConstants.ErrorMessages.NOT_FOUND)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_VERIFICATION_CODE, message  : AppConstants.ErrorMessages.INVALID_VERIFICATION_CODE)
//        errorResolver.registerErrorCode(ErrorCodes.EMAIL_ALREADY_REGISTERED, message  : AppConstants.ErrorMessages.EMAIL_ALREADY_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.PHONE_ALREADY_REGISTERED, message  : AppConstants.ErrorMessages.PHONE_ALREADY_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_REGISTERED, message  : AppConstants.ErrorMessages.ALREADY_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.PHONE_NOT_VERIFIED, message  : AppConstants.ErrorMessages.PHONE_NOT_VERIFIED)
//        errorResolver.registerErrorCode(ErrorCodes.ACCOUNT_DISABLED, message  : AppConstants.ErrorMessages.ACCOUNT_DISABLED_MESSAGE)
//        errorResolver.registerErrorCode(ErrorCodes.ACCOUNT_UNVERIFIED, message  : AppConstants.ErrorMessages.ACCOUNT_UNVERIFIED)
//        errorResolver.registerErrorCode(ErrorCodes.PHONE_NOT_REGISTERED, message  : AppConstants.ErrorMessages.PHONE_NOT_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.EMAIL_NOT_REGISTERED, message  : AppConstants.ErrorMessages.EMAIL_NOT_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.NOT_REGISTERED, message  : AppConstants.ErrorMessages.NOT_REGISTERED)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_INPUT_FORMAT, message  : AppConstants.ErrorMessages.INVALID_INPUT_FORMAT)
//        errorResolver.registerErrorCode(ErrorCodes.INPUT_TOO_LARGE, message  : AppConstants.ErrorMessages.INPUT_TOO_LARGE)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_KEY, message  : AppConstants.ErrorMessages.INVALID_KEY)
//        errorResolver.registerErrorCode(ErrorCodes.LIMIT_REACHED, message  : AppConstants.ErrorMessages.LIMIT_REACHED)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_EXIST, message  : AppConstants.ErrorMessages.ALREADY_EXIST)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_BIDDING, message  : AppConstants.ErrorMessages.ALREADY_BIDDING)
//        errorResolver.registerErrorCode(ErrorCodes.DRIVER_OFFLINE, message  : AppConstants.ErrorMessages.DRIVER_OFFLINE)
//        errorResolver.registerErrorCode(ErrorCodes.DRIVER_ON_TRIP, message  : AppConstants.ErrorMessages.DRIVER_ON_TRIP)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_ON_TRIP, message  : AppConstants.ErrorMessages.ALREADY_ON_TRIP)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_DRIVER, message  : AppConstants.ErrorMessages.INVALID_DRIVER)
//        errorResolver.registerErrorCode(ErrorCodes.BIDDING_CLOSED, message  : AppConstants.ErrorMessages.BIDDING_CLOSED)
//        errorResolver.registerErrorCode(ErrorCodes.BIDDING_EXPIRED, message  : AppConstants.ErrorMessages.BIDDING_EXPIRED)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_COUNTERED, message  : AppConstants.ErrorMessages.ALREADY_COUNTERED)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_COUNTER_PRICE, message  : AppConstants.ErrorMessages.INVALID_COUNTER_PRICE)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_RIDER, message  : AppConstants.ErrorMessages.INVALID_RIDER)
//        errorResolver.registerErrorCode(ErrorCodes.STRIPE_ACCOUNT_IN_USE, message  : AppConstants.ErrorMessages.STRIPE_ACCOUNT_IN_USE)
//        errorResolver.registerErrorCode(ErrorCodes.PAYMENT_DRIVER_NO_ACCOUNT, message  : AppConstants.ErrorMessages.PAYMENT_DRIVER_NO_ACCOUNT)
//        errorResolver.registerErrorCode(ErrorCodes.PAYMENT_RIDER_NO_SOURCE, message  : AppConstants.ErrorMessages.PAYMENT_RIDER_NO_SOURCE)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_PAID, message  : AppConstants.ErrorMessages.ALREADY_PAID)
//        errorResolver.registerErrorCode(ErrorCodes.PAYMENT_FAILED, message  : AppConstants.ErrorMessages.PAYMENT_FAILED)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_TRIP_STATUS, message  : AppConstants.ErrorMessages.INVALID_TRIP_STATUS)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_CANCELLED, message  : AppConstants.ErrorMessages.ALREADY_CANCELLED)
//        errorResolver.registerErrorCode(ErrorCodes.CANNOT_BID_SELF, message  : AppConstants.ErrorMessages.CANNOT_BID_SELF)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_ENDED, message  : AppConstants.ErrorMessages.ALREADY_ENDED)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_IMAGE_ID, message  : AppConstants.ErrorMessages.INVALID_IMAGE_ID)
//        errorResolver.registerErrorCode(ErrorCodes.ON_TRIP, message  : AppConstants.ErrorMessages.ON_TRIP)
//        errorResolver.registerErrorCode(ErrorCodes.UNKNOWN_DRIVER_LOCATION, message  : AppConstants.ErrorMessages.UNKNOWN_DRIVER_LOCATION)
//        errorResolver.registerErrorCode(ErrorCodes.TRIP_NOT_STARTED_YET, message  : AppConstants.ErrorMessages.TRIP_NOT_STARTED_YET)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_ADDED_STOP, message  : AppConstants.ErrorMessages.ALREADY_ADDED_STOP)
//        errorResolver.registerErrorCode(ErrorCodes.ALREADY_VISITED, message  : AppConstants.ErrorMessages.ALREADY_VISITED_MESSAGE)
//        errorResolver.registerErrorCode(ErrorCodes.STOP_NOT_FOUND, message  : AppConstants.ErrorMessages.STOP_NOT_FOUND)
//        errorResolver.registerErrorCode(ErrorCodes.EMERGENCY_CONTACT_NOT_ADDED, message  : AppConstants.ErrorMessages.EMERGENCY_CONTACT_NOT_ADDED)
//        errorResolver.registerErrorCode(ErrorCodes.STRIPE_ERROR, message  : AppConstants.ErrorMessages.STRIPE_ERROR)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_OLD_PASSWORD, message  : AppConstants.ErrorMessages.INVALID_OLD_PASSWORD)
//
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_WEEK_START_DAY, message  : AppConstants.ErrorMessages.INVALID_WEEK_START_DAY)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_WEEK_END_DAY, message  : AppConstants.ErrorMessages.INVALID_WEEK_END_DAY)
//        errorResolver.registerErrorCode(ErrorCodes.INVALID_MONTH_DATE, message  : AppConstants.ErrorMessages.INVALID_MONTH_DATE)
//
//         errorResolver.registerErrorCode(ErrorCodes.PRICING_ENGINE_ERROR, message  : AppConstants.ErrorMessages.PRICING_ENGINE_ERROR)
//         errorResolver.registerErrorCode(ErrorCodes.AREA_NOT_COVERED, message  : AppConstants.ErrorMessages.AREA_NOT_COVERED)
//         errorResolver.registerErrorCode(ErrorCodes.STATE_NOT_COVERED, message  : AppConstants.ErrorMessages.STATE_NOT_COVERED)
//         errorResolver.registerErrorCode(ErrorCodes.JSON_REQUEST_SPECIFICATION_ERROR, message  : AppConstants.ErrorMessages.JSON_REQUEST_SPECIFICATION_ERROR)
//         errorResolver.registerErrorCode(ErrorCodes.WEATHER_SERVICE_ISSUE, message  : AppConstants.ErrorMessages.WEATHER_SERVICE_ISSUE)
//        errorResolver.registerErrorCode(ErrorCodes.PRICING_SERVER_STATE_ERROR, message  : AppConstants.ErrorMessages.PRICING_SERVER_STATE_ERROR)
        
       

        return errorResolver
        
    }
    
    class func message(forErrorCode code:Int)->String {
        switch code {
        case 2000:
            return AppConstants.ErrorMessages.UNABLE_TO_PARSE_JSON
        case 2001:
            return AppConstants.ErrorMessages.REQUIRED_PARAMETER_MISSING
        case 2002:
            return AppConstants.ErrorMessages.INVALID_PARAMETER_FORMAT
        case 2003:
            return AppConstants.ErrorMessages.INVALID_PARAMETER_VALUE
        case 2004:
            return AppConstants.ErrorMessages.PARAMETER_VALUE_EXCEEDS
        case 2006:
            return AppConstants.ErrorMessages.UNABLE_TO_PARSE_THE_REQUEST
        case 2007:
            return AppConstants.ErrorMessages.UNSUPPORTED_EXPORT_FORMAT
        case 2008:
            return AppConstants.ErrorMessages.EMPTY_ELEMENT
        case 2009:
            return AppConstants.ErrorMessages.ROUTE_NOT_FOUND
        case 2010:
            return AppConstants.ErrorMessages.ROUTE_NOT_FOUND
        case 2099:
             return AppConstants.ErrorMessages.UNKNOWN_INTERNAL_ERROR
        default:
            return ""
        }
    }
}
