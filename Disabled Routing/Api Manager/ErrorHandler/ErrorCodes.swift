

import Foundation

enum ErrorCodes:Int {
    
    //Common
    case BAD_REQUEST    = 400
    case UNAUTHORIZED   = 401
    case METHOD_NOT_ALLOWED = 405
    case LARGE_REQUEST = 413
    case INTERNAL_SERVER_ERROR = 500
    case FACILITY_NOT_SUPPORTED = 501
    case SERVER_OVERLOAD = 503
}
