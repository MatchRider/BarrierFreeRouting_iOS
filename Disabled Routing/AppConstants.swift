/**
 Contains all the constants related to the application
 */

import Foundation

struct AppConstants{
    
    struct PListKeys{
        static let BASE_URL_KEY = "BASE_URL"
        static let SOCKET_URL_KEY = "SOCKET_URL"
        static let APP_LANGUAGE_KEY = "APP_LANGUAGE"
        static let OSM_API_BASE_URL = "OSM_API_BASE_URL"
        static let AUTH_TOKEN = "AUTH_TOKEN"
        static let WHEEL_MAP_BASE_URL = "WHEEL_MAP_BASE_URL"
        static let DISABLED_ROUTING_BASE_URL = "DISABLED_ROUTING_BASE_URL"
        static let SEARCH_COUNTRY = "SEARCH_COUNTRY"
        
        static let CONSUMER_KEY = "CONSUMER_KEY"
        static let CONSUMER_SECRET = "CONSUMER_SECRET"
        static let REQUEST_TOKEN_URL = "REQUEST_TOKEN_URL"
        static let AUTHORIZE_TOKEN_URL = "AUTHORIZE_TOKEN_URL"
        static let ACCESS_TOKEN_URL = "ACCESS_TOKEN_URL"
    }
    struct OAUTHSettings {
        static let CONSUMER_KEY:String = PListUtility.getValue(forKey: AppConstants.PListKeys.CONSUMER_KEY) as! String
        static let CONSUMER_SECRET:String = PListUtility.getValue(forKey: AppConstants.PListKeys.CONSUMER_SECRET) as! String
        static let REQUEST_TOKEN_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.REQUEST_TOKEN_URL) as! String
        static let AUTHORIZE_TOKEN_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.AUTHORIZE_TOKEN_URL) as! String
        static let ACCESS_TOKEN_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.ACCESS_TOKEN_URL) as! String
    }
    struct AppLanguages {
        static let DEFAULT_LANGUAGE:String = NSLocale.current.languageCode!
    }
    struct Auth {
        static let KEY:String = UserDefaultUtility.retrieveStringWithKey(PListKeys.AUTH_TOKEN)//PListUtility.getValue(forKey: AppConstants.PListKeys.AUTH_TOKEN) as! String
    }
    //MARK:This structure contains Api URLs
    
    struct URL{
        static let BASE_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.BASE_URL_KEY) as! String
        static let OSM_BASE_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.OSM_API_BASE_URL) as! String
        static let WHEEL_MAP_BASE_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.WHEEL_MAP_BASE_URL) as! String
        static let DISABLED_ROUTING_BASE_URL:String = PListUtility.getValue(forKey: AppConstants.PListKeys.DISABLED_ROUTING_BASE_URL) as! String
    }
    
    //MARK:This structure contains Api End Points
    
    struct ApiEndPoints {
        static let DIRECTIONS = "/directions?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)&coordinates=%@&format=geojson&language=\(AppConstants.AppLanguages.DEFAULT_LANGUAGE)&elevation=true&profile=wheelchair&options={\"profile_params\":{\"restrictions\":{%@}}}"
        static let DIRECTIONS_WITHOUT_FILTERS = "/directions?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)&coordinates=%@&profile=wheelchair&elevation=true&language=\(AppConstants.AppLanguages.DEFAULT_LANGUAGE)&format=geojson"
        static let GEOCODING = "/geocode/search?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)&%@&layers=venue,address&boundary.circle.radius=5&boundary.country=DEU"//\(PListUtility.getValue(forKey: AppConstants.PListKeys.SEARCH_COUNTRY) as! String)"
        static let REVERSE_GEOCODING = "/geocode/reverse?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)&%@&size=1"//&lang=\(AppLanguages.DEFAULT_LANGUAGE)"
        static let OSM_CREATE_NODE = "node/create"
         static let OSM_CREATE_WAY = "way/create"
        static let OSM_CREATE_CHANGE_SET = "changeset/create"
        static let OSM_UPDATE_WAY = "way/%@"
        static let OSM_UPDATE_NODE = "node/%@"
        static let GET_NODES = "api/nodes?api_key=\(AppConstants.APIRequestHeaders.WHEEL_MAP_API_KEY)&bbox=%f,%f,%f,%f&per_page=10000&wheelchair=yes"
        static let GET_WAYS = "map?bbox=left,bottom,right,top"
        static let GET_WAY_INFO = "Get/"
        static let UPDATE_WAY_INFO = "Update"
        static let UPDATE_NODE_INFO = "UpdateNode"
        static let VALIDATE_WAY_INFO = "Validate/"
        static let WAY_LIST = "List/"
        static let OSM_DATA = "map?bbox=8.672704,49.40659,8.720019,49.415246"//"map?bbox=8.662997,49.405089,8.697251,49.416175"
        static let GET_USER_DETAILS = "user/details"
    }
    
    //MARK:- This structure contains Error message for various events
    
    struct ValidationErrors{
        static let ENTER_PHONE_NUMBER = "Please enter the phone number"
        static let NO_ADDRESS_FOUND = "No address found.".localized()
    }
    
    //MARK:- This structure contains Request header keys
    
    struct APIRequestHeaders {
        static let CONTENT_TYPE = "Content-Type"
        static let APPLICATION_JSON = "application/json"
        static let API_KEY = "api_key"
        static let AUTH_TOKEN = "Authorization"
        static let AUTH_TOKEN_VALUE = "Basic c2h1YmhhbS5zYWhnYWxAZGFmZm9kaWxzdy5jb206U2h1YmhhbUAwOTEx"
        static let API_KEY_VALUE = "58d904a497c67e00015b45fc2deebb0cd8724d54ba2d7d57c525bf8d"
        static let WHEEL_MAP_API_KEY = "b4W1zzy2xnWjwjKQ87Tu"
    }
    
    struct App {
        static let APP_NAME = "APP_NAME".localized()
        static let APP_VERSION_NUMBER = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
        static let APP_BUILD_NUMBER = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
        static var COMPILE_DATE:String
        {
            let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "Info.plist"
            let formattter = DateFormatter.init(withFormat: "dd-MM-yyy", locale: "en_US_POSIX")
           
            if let infoPath = Bundle.main.path(forResource: bundleName, ofType: nil),
                let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath) {
                return formattter.string(from: infoAttr[FileAttributeKey.creationDate] as? Date ?? Date())
             }
            return formattter.string(from:Date())
        }
        static let APP_INFO = "iOS:\(APP_VERSION_NUMBER)(\(APP_BUILD_NUMBER))|\(COMPILE_DATE)"
    }
    //MARK:- This structure contains keys for error handling
    
    struct ErrorHandlingKeys{
        
        static let IS_ERROR = ""
        static let ERROR_KEY = "code"
        static let ERROR_DETAIL = "detail"
    }
    
    //MARK:- This structure contains the error messages corresponding to error code
    
    struct ErrorMessages{
        static let ALERT_TITLE = "Alert".localized()
        static let MESSAGE_TITLE = "Message".localized()
        static let INVALID_KEY_MESSAGE = "Valid api key is required. Please provide a valid api key along with request"
        static let SOME_ERROR_OCCURED = "SOME_ERROR_OCCURED".localized()
        static let DATA_NOT_SAVED = "DATA_NOT_SAVED".localized()
        static let REQUEST_TIME_OUT = "Request time out"
        static let PLEASE_CHECK_YOUR_INTERNET_CONNECTION = "INTERNET_MESSAGE".localized()
        static let MESSAGE_TO_PROCEED = "MESSAGE_TO_PROCEED".localized()
        static let OTHER_VALUE = "OTHER_VALUE".localized()
        //Direction API
        static let BAD_REQUEST    = "Unable to show direction for this path. Please try different locations"
        static let UNAUTHORIZED   = "You are not authorized to access this functionality"
        static let METHOD_NOT_ALLOWED = "The specified HTTP method is not supported."
        static let LARGE_REQUEST = "The request is larger than the server is able to process, the data provided in the request exceeds the capacity limit."
        static let INTERNAL_SERVER_ERROR = "The request is incorrect and therefore can not be processed."
        static let FACILITY_NOT_SUPPORTED = "The server does not support the functionality needed to fulfill the request."
        static let SERVER_OVERLOAD = "The server is currently unavailable due to overload or maintenance."
        
        static let UNABLE_TO_PARSE_JSON = "UNABLE_TO_PARSE_JSON".localized();
        static let REQUIRED_PARAMETER_MISSING = "REQUIRED_PARAMETER_MISSING".localized();
        static let INVALID_PARAMETER_FORMAT = "INVALID_PARAMETER_FORMAT".localized();
        static let INVALID_PARAMETER_VALUE = "INVALID_PARAMETER_VALUE".localized();
        static let PARAMETER_VALUE_EXCEEDS = "PARAMETER_VALUE_EXCEEDS".localized();
        static let UNABLE_TO_PARSE_THE_REQUEST = "UNABLE_TO_PARSE_THE_REQUEST".localized();
        static let UNSUPPORTED_EXPORT_FORMAT = "UNSUPPORTED_EXPORT_FORMAT".localized();
        static let EMPTY_ELEMENT = "EMPTY_ELEMENT".localized();
        static let ROUTE_NOT_FOUND = "ROUTE_NOT_FOUND".localized();
        static let UNKNOWN_INTERNAL_ERROR = "UNKNOWN_INTERNAL_ERROR".localized();
    }
    
    struct ScreenSpecificConstant {
        struct Common{
            static let BACK_BUTTON_TITLE = "BACK_BUTTON_TITLE".localized()
            static let SKIP_BUTTON_TITLE = "SKIP_BUTTON_TITLE".localized()
            static let EMPTY_STRING = ""
            static let LOGOUT_TITLE = ""
            static let YES_TITLE = "YES_TITLE".localized()
            static let OK_TITLE = "Ok"
            static let NO_TITLE = "NO_TITLE".localized()
            static let Cancel_TITLE = "Cancel".localized()
            static let LOGOUT_MESSAGE = "LOGOUT_MESSAGE".localized()
            static let SETTINGS = "Go To Settings"
            static let ACCESS_DENIED = "Access Denied"
            static let CONTACT_ACCESS_PERMISSION_MESSAGE = "Please allow the app to access your contacts through the Settings"
            static let SAVE_BUTTON_TITLE = "Save"
            static let EDIT_BUTTON_TITLE = "Edit"
            static let CM = "CM".localized()
        }
        struct ThankYouScreen {
            static let THANK_YOU_TEXT = "THANK_YOU_TEXT".localized()
            static let HOME_TITLE = "HOME_TITLE".localized()
        }
        struct ContactScreen {
            static let EMAIL_SUBJECT = "EMAIL_SUBJECT".localized()
            static let RECPIENT_MAIL = "buergerservice@Heidelberg.de"
        }
        struct LoginScreen {
            static let OSM_CALL_BACK_URL = "disabled-routing://oauth-callback/"
        }
        struct HomeScreen {
            static let ROUTE_PLANNER = "ROUTE_PLANNER"
            static let SUGGESTION = "SUGGESTION"
            static let ENHANCE_ROUTING_TEXT_LINE1 = "ENHANCE_ROUTING_TEXT_LINE1".localized()
            static let ENHANCE_ROUTING_TEXT_LINE2 = "ENHANCE_ROUTING_TEXT_LINE2".localized()
        }
        struct MapScreen {
            static let FROM_LOCATION_PLACEHOLDER    = "FROM_LOCATION_PLACEHOLDER".localized()
            static let TO_LOCATION_PLACEHOLDER      = "TO_LOCATION_PLACEHOLDER".localized()
            static let TOILETS_TITLE    = "TOILETS_TITLE".localized()
            static let PARKING_TITLE    = "PARKING_TITLE".localized()
            static let BUS_STOP_TITLE   = "BUS_STOP_TITLE".localized()
            static let TRAM_STOP_TITLE  = "TRAM_STOP_TITLE".localized()
            static let GO_BUTTON_TITLE  = "GO_BUTTON_TITLE".localized()
            static let START_TITLE      = "START_TITLE".localized()
            static let ENHANCE_TEXT =       "ENHANCE_TEXT".localized()
            static let SORRY_TEXT   =   "SORRY_TEXT".localized()
            static let OK_TEXT      = "OK".localized()
            static let NEXT_TIME_TEXT = "NEXT_TIME_TEXT".localized()
            static let LOOK_CLOSER_TEXT_NODE = "LOOK_CLOSER_TEXT_NODE".localized()
            static let LOOK_CLOSER_TEXT_WAY = "LOOK_CLOSER_TEXT_WAY".localized()
          //  static let LOOK_CLOSER_NODE_TEXT = "LOOK_CLOSER_NODE_TEXT".localized()
            static let FOLLOWING_CORRECT_TEXT = "FOLLOWING_CORRECT_TEXT".localized()
            static let POLYLINE_VALID_COLOR = "#008000"
            static let POLYLINE_INVALID_COLOR = "#7F0000"
            static let VALID_WAYS = "VALID_WAYS".localized();
            static let IN_VALID_WAYS = "IN_VALID_WAYS".localized();
            static let OSM = "OSM".localized();
            static let NODE = "NODE".localized();
            static let WAY = "WAY".localized();
            static let HOUR = "HOUR".localized();
            static let MIN = "MIN".localized();
            static let CITY_CENTER_LATITIUDE =  49.4059022
            static let CITY_CENTER_LONGITUDE =  8.6762875
        }
        struct SideMenuScreen {
            
            static let IMPRINT = "IMPRINT".localized()
            static let ACKNOWLEDGEMENTS = "ACKNOWLEDGEMENTS".localized()
            static let FEEDBACK = "FEEDBACK"
            static let CONTACT = "CONTACT".localized()
            static let DISCLAIMER = "DISCLAIMER".localized()
            static let COMING_SOON = "COMING_SOON".localized()
            static let LEGAL = "LEGAL".localized()
            static let IMPRINT_DETAIL = "IMPRINT_DETAIL".localized()
            static let IMPRINT_DETAIL_PART_1 = "IMPRINT_DETAIL_PART_1".localized()
            static let IMPRINT_DETAIL_PART_2 = "IMPRINT_DETAIL_PART_2".localized()
            static let IMPRINT_DETAIL_PART_3 = "IMPRINT_DETAIL_PART_3".localized()
            static let IMPRINT_DETAIL_PART_4 = "IMPRINT_DETAIL_PART_4".localized()
            static let LOG_OUT = "LOG_OUT".localized()
        }
        struct FilterOptionScreen {
            
            /*SERVER VALUES*/
            //Surface Type Options
            static let SURFACE_VALUE_ONE = "SURFACE_VALUE_ONE".localized()
            static let SURFACE_VALUE_TWO = "SURFACE_VALUE_TWO".localized()
            static let SURFACE_VALUE_THREE = "SURFACE_VALUE_THREE".localized()
            static let SURFACE_VALUE_FOUR = "SURFACE_VALUE_FOUR".localized()
            static let SURFACE_VALUE_FIVE = "SURFACE_VALUE_FIVE".localized()

            //Maximum Sloped Curb
            static let SLOPED_VALUE_ONE = "SLOPED_VALUE_ONE".localized()
            static let SLOPED_VALUE_TWO = "SLOPED_VALUE_TWO".localized()
            static let SLOPED_VALUE_THREE = "SLOPED_VALUE_THREE".localized()
            static let SLOPED_VALUE_FOUR = "SLOPED_VALUE_FOUR".localized()

            //Maximum Incline
            static let INCLINE_VALUE_ONE = "INCLINE_VALUE_ONE".localized()
            static let INCLINE_VALUE_TWO = "INCLINE_VALUE_TWO".localized()
            static let INCLINE_VALUE_THREE = "INCLINE_VALUE_THREE".localized()
            static let INCLINE_VALUE_FOUR = "INCLINE_VALUE_FOUR".localized()
            static let INCLINE_VALUE_FIVE = "INCLINE_VALUE_FIVE".localized()

            //Width Options
            static let WIDTH_VALUE_ONE = "WIDTH_VALUE_ONE".localized()
            static let WIDTH_VALUE_TWO = "WIDTH_VALUE_TWO".localized()
            
            /*SCREEN VALUES*/
            //Surface Type Options
            static let SURFACE_OPTIONS_ONE = "SURFACE_OPTIONS_ONE".localized()
            static let SURFACE_OPTIONS_TWO = "SURFACE_OPTIONS_TWO".localized()
            static let SURFACE_OPTIONS_THREE = "SURFACE_OPTIONS_THREE".localized()
            static let SURFACE_OPTIONS_FOUR = "SURFACE_OPTIONS_FOUR".localized()
            static let SURFACE_OPTIONS_FIVE = "SURFACE_OPTIONS_FIVE".localized()
            
            //Maximum Sloped Curb
            static let SLOPED_OPTIONS_ONE = "SLOPED_OPTIONS_ONE".localized()
            static let SLOPED_OPTIONS_TWO = "SLOPED_OPTIONS_TWO".localized()
            static let SLOPED_OPTIONS_THREE = "SLOPED_OPTIONS_THREE".localized()
            static let SLOPED_OPTIONS_FOUR = "SLOPED_OPTIONS_FOUR".localized()
            
            //Maximum Incline
            static let INCLINE_OPTIONS_ONE = "INCLINE_OPTIONS_ONE".localized()
            static let INCLINE_OPTIONS_TWO = "INCLINE_OPTIONS_TWO".localized()
            static let INCLINE_OPTIONS_THREE = "INCLINE_OPTIONS_THREE".localized()
            static let INCLINE_OPTIONS_FOUR = "INCLINE_OPTIONS_FOUR".localized()
            static let INCLINE_OPTIONS_FIVE = "INCLINE_OPTIONS_FIVE".localized()
            
            //Width Options
            static let WIDTH_OPTIONS_ONE = "WIDTH_OPTIONS_ONE".localized()
            static let WIDTH_OPTIONS_TWO = "WIDTH_OPTIONS_TWO".localized()

            static let SURFACE_TYPE = "SURFACE_TYPE".localized()
            static let MAXIMUM_SLOPED_CURB = "MAXIMUM_SLOPED_CURB".localized()
            static let MAXIMUM_INCLINE = "MAXIMUM_INCLINE".localized()
            static let SIDEWALK_WIDTH = "SIDEWALK_WIDTH".localized()
            
            static let titlesKey = ["surface_type","maximum_sloped_curb","maximum_incline","width"]
            
            //All traversable surfaces
            static let surfaceTypeOptions = [SURFACE_OPTIONS_ONE,SURFACE_OPTIONS_TWO,SURFACE_OPTIONS_THREE,SURFACE_OPTIONS_FOUR,SURFACE_OPTIONS_FIVE]
            static let surfaceTypeOptionsValues = [SURFACE_VALUE_ONE,SURFACE_VALUE_TWO,SURFACE_VALUE_THREE,SURFACE_VALUE_FOUR,SURFACE_VALUE_FIVE]
            
            static let slopedCurbOptions = [SLOPED_OPTIONS_ONE,SLOPED_OPTIONS_TWO,SLOPED_OPTIONS_THREE,SLOPED_OPTIONS_FOUR]
            static let slopedCurbOptionsValues = [SLOPED_VALUE_ONE,SLOPED_VALUE_TWO,SLOPED_VALUE_THREE,SLOPED_VALUE_FOUR]
            
            // static let slopedCurbOptions = ["0","1.2".localized(),"2.4".localized(),"ueber\("2.4".localized())"]
            static let pitchOptions = [INCLINE_OPTIONS_ONE,INCLINE_OPTIONS_TWO,INCLINE_OPTIONS_THREE,INCLINE_OPTIONS_FOUR,INCLINE_OPTIONS_FIVE]
            static let pitchOptionsValues = [INCLINE_VALUE_ONE,INCLINE_VALUE_TWO,INCLINE_VALUE_THREE,INCLINE_VALUE_FOUR,INCLINE_VALUE_FIVE]
            
            
            static let sideWalkOptions = [WIDTH_OPTIONS_ONE,WIDTH_OPTIONS_TWO]
            static let sideWalkOptionsValues = [WIDTH_VALUE_ONE,WIDTH_VALUE_TWO]
            
            static let obstacleOptions = ["YES_TITLE".localized(),"NO_TITLE".localized()]
            //TRACK_TYPE,SMOOTHNESS_GRADE,
            static let titles = [ROUTING_TEXT,SURFACE_TYPE,MAXIMUM_SLOPED_CURB,MAXIMUM_INCLINE,SIDEWALK_WIDTH]
            //,trackTypeOptions,smoothnessOptions,
            static let titlesOptionsText = [[""],surfaceTypeOptions,slopedCurbOptions,pitchOptions,sideWalkOptions]
            //trackTypeOptions,smoothnessOptions,
            static let titlesOptionsValues = [[""],surfaceTypeOptionsValues,slopedCurbOptionsValues,pitchOptionsValues,sideWalkOptionsValues]
            static let OPTIONS = "OPTIONS".localized()
            static let IMPROVE_ROUTING_TITLE = "IMPROVE_ROUTING_TITLE".localized()
            static let CAPTURE_QUESTION = "CAPTURE_QUESTION".localized()
            static let FEEDBACK_QUESTION = "FEEDBACK_QUESTION".localized()
            static let ROUTING_TEXT = "ROUTING_TEXT".localized()
            static let ENTER_LOCATION = "ENTER_LOCATION".localized()
            static let APPLY_TITLE = "APPLY_TITLE".localized()
            static let CLEAR_TITLE = "CLEAR_TITLE".localized()
            static let FINISHED_TITLE = "FINISHED_TITLE".localized()
        }
        struct InformationScreen {
            static let SURFACE_TYPE = "SURFACE_TYPE".localized()
            static let TRACK_TYPE = "Track type"
            static let SMOOTHNESS_GRADE = "Smotheness grade"
            static let MAXIMUM_SLOPED_CURB = "\("MAXIMUM_SLOPED_CURB".localized())"
            static let MAXIMUM_INCLINE = "MAXIMUM_INCLINE".localized()
            static let SIDEWALK_WIDTH = "\("SIDEWALK_WIDTH".localized())"
            static let PERMANENT_OBSTACLE = "PERMANENT_OBSTACLE".localized()
            //"highway","smoothness",
            static let titlesKey = ["surface","sloped_curb","incline","width","obstacle"]
            
            static let surfaceTypeOptions = ["Asphalt".localized(),"Concrete".localized(),"Paving Stones".localized(),"Cobblestone".localized(),"Compacted".localized()]
            static let surfaceTypeOptionsValues = ["asphalt","concrete_plates","paving_stones","cobblestone","grass_pavers","gravel"]
            
            static let trackTypeOptionsValues = ["cycleway","footway","living_street","pedestrian","cobblestone"]
            static let trackTypeOptions = ["Cycleway".localized(),"Footway".localized(),"Living Street".localized(),"Pedestrian".localized(),"Cobblestone".localized()]
            
            static let smoothnessOptions = ["Good".localized(),"Intermediate".localized(),"Bad".localized()]
            static let smoothnessOptionsValues = ["good","intermediate","bad"]
            static let slopedCurbOptions = ["0","3".localized(),"6".localized(),"ueber\("6".localized())"]
            //   static let slopedCurbOptions = ["0","1.2".localized(),"2.4".localized(),"ueber\("2.4".localized())"]
            static let pitchOptions = ["0","bis 3".localized(),"bis 6".localized(),"bis 10".localized(),"ueber 10"]
            
            static let sideWalkOptions = ["bis 90","90-120","ueber 120"]
            
            static let obstacleOptions = ["YES_TITLE".localized(),"NO_TITLE".localized()]
            //TRACK_TYPE,SMOOTHNESS_GRADE,
            static let titles = [SURFACE_TYPE,MAXIMUM_SLOPED_CURB,MAXIMUM_INCLINE,SIDEWALK_WIDTH,PERMANENT_OBSTACLE]
            //,trackTypeOptions,smoothnessOptions,
            static let titlesOptions = [surfaceTypeOptions,slopedCurbOptions,pitchOptions,sideWalkOptions,obstacleOptions]
            //trackTypeOptions,smoothnessOptions,
            static let values = [surfaceTypeOptions,slopedCurbOptions,pitchOptions,sideWalkOptions,obstacleOptions]
            
            static let IMPROVE_ROUTING_TITLE = "IMPROVE_ROUTING_TITLE".localized()
            static let OPTIONS = "OPTIONS".localized()
            static let CAPTURE_QUESTION = "CAPTURE_QUESTION".localized()
            static let FEEDBACK_QUESTION = "FEEDBACK_QUESTION".localized()
            
            static let APPLY_TITLE = "APPLY_TITLE".localized()
            static let CLEAR_TITLE = "CLEAR_TITLE".localized()
            static let FINISHED_TITLE = "FINISHED_TITLE".localized()
        }
        struct LocationPickScreen {
            static let TELL_US_TEXT = "TELL_US_TEXT".localized()
            static let FEEDBACK_QUES_TEXT = "FEEDBACK_QUES_TEXT".localized()
            static let NO_ANSWER_TEXT = "NO_ANSWER_TEXT".localized()
            static let YES_ANSWER_TEXT = "YES_ANSWER_TEXT".localized()
            static let ENHANCE_ROUTING_TEXT = "ENHANCE_ROUTING_TEXT".localized()
        }
        struct LegalController {
              static let LEGAL_TEXT = "LEGAL_TEXT".localized()
        }
        struct ValidationScreen {
            
                //VALIDATION SCREEN VALUES


                static let SURFACE_TYPE_TITLE = "SURFACE_TYPE_TITLE".localized()
                static let INCLINE_TITLE = "INCLINE_TITLE".localized()
                static let WIDTH_TITLE = "WIDTH_TITLE".localized()

                //Surface Type Values
                static let SURFACE_OSM_OPTION_ONE = "SURFACE_OSM_OPTION_ONE".localized()
                static let SURFACE_OSM_OPTION_TWO = "SURFACE_OSM_OPTION_TWO".localized()
                static let SURFACE_OSM_OPTION_THREE =  "SURFACE_OSM_OPTION_THREE".localized()
                static let SURFACE_OSM_OPTION_FOUR =  "SURFACE_OSM_OPTION_FOUR".localized()
                static let SURFACE_OSM_OPTION_FIVE = "SURFACE_OSM_OPTION_FIVE".localized()

                //Surface Type Options
                static let SURFACE_OSM_VALUE_ONE = "SURFACE_OSM_VALUE_ONE".localized()
                static let SURFACE_OSM_VALUE_TWO = "SURFACE_OSM_VALUE_TWO".localized()
                static let SURFACE_OSM_VALUE_THREE = "SURFACE_OSM_VALUE_THREE".localized()
                static let SURFACE_OSM_VALUE_FOUR = "SURFACE_OSM_VALUE_FOUR".localized()
                static let SURFACE_OSM_VALUE_FIVE = "SURFACE_OSM_VALUE_FIVE".localized()

                //Width Values
                static let WIDTH_OSM_VALUE_ONE = "WIDTH_OSM_VALUE_ONE".localized()
                static let WIDTH_OSM_VALUE_TWO = "WIDTH_OSM_VALUE_TWO".localized()

                //Width Options

                static let WIDTH_OSM_OPTION_ONE = "WIDTH_OSM_OPTION_ONE".localized()
                static let WIDTH_OSM_OPTION_TWO = "WIDTH_OSM_OPTION_TWO".localized()

                //Incline Values
                static let INCLINE_OSM_VALUE_ZERO   =  "INCLINE_OSM_VALUE_ZERO".localized()
                static let INCLINE_OSM_VALUE_ONE    =  "INCLINE_OSM_VALUE_ONE".localized()
                static let INCLINE_OSM_VALUE_TWO    =  "INCLINE_OSM_VALUE_TWO".localized()
                static let INCLINE_OSM_VALUE_THREE  = "INCLINE_OSM_VALUE_THREE".localized()
                static let INCLINE_OSM_VALUE_FOUR   = "INCLINE_OSM_VALUE_FOUR".localized()
                static let INCLINE_OSM_VALUE_FIVE   = "INCLINE_OSM_VALUE_FIVE".localized()
                static let INCLINE_OSM_VALUE_SIX    =  "INCLINE_OSM_VALUE_SIX".localized()
                static let INCLINE_OSM_VALUE_SEVEN    =  "INCLINE_OSM_VALUE_SEVEN".localized()
                static let INCLINE_OSM_VALUE_EIGHT  = "INCLINE_OSM_VALUE_EIGHT".localized()
                static let INCLINE_OSM_VALUE_NINE   = "INCLINE_OSM_VALUE_NINE".localized()
                static let INCLINE_OSM_VALUE_TEN   = "INCLINE_OSM_VALUE_TEN".localized()
                static let INCLINE_OSM_VALUE_ELEVEN   = "INCLINE_OSM_VALUE_ELEVEN".localized()
            
                //Incline Options
                static let INCLINE_OSM_OPTION_ZERO = "INCLINE_OSM_OPTION_ZERO".localized()
                static let INCLINE_OSM_OPTION_ONE = "INCLINE_OSM_OPTION_ONE".localized()
                static let INCLINE_OSM_OPTION_TWO = "INCLINE_OSM_OPTION_TWO".localized()
                static let INCLINE_OSM_OPTION_THREE = "INCLINE_OSM_OPTION_THREE".localized()
                static let INCLINE_OSM_OPTION_FOUR = "INCLINE_OSM_OPTION_FOUR".localized()
                static let INCLINE_OSM_OPTION_FIVE = "INCLINE_OSM_OPTION_FIVE".localized()
                static let INCLINE_OSM_OPTION_SIX = "INCLINE_OSM_OPTION_SIX".localized()
                static let INCLINE_OSM_OPTION_SEVEN = "INCLINE_OSM_OPTION_SEVEN".localized()
                static let INCLINE_OSM_OPTION_EIGHT = "INCLINE_OSM_OPTION_EIGHT".localized()
                static let INCLINE_OSM_OPTION_NINE = "INCLINE_OSM_OPTION_NINE".localized()
                static let INCLINE_OSM_OPTION_TEN = "INCLINE_OSM_OPTION_TEN".localized()
                static let INCLINE_OSM_OPTION_ELEVEN = "INCLINE_OSM_OPTION_ELEVEN".localized()
            
            
            static let SLOPED_OSM_VALUE_ONE = "SLOPED_OSM_VALUE_ONE".localized()
            static let SLOPED_OSM_VALUE_TWO = "SLOPED_OSM_VALUE_TWO".localized()
            static let SLOPED_OSM_VALUE_THREE = "SLOPED_OSM_VALUE_THREE".localized()
            static let SLOPED_OSM_VALUE_FOUR = "SLOPED_OSM_VALUE_FOUR".localized()
            
            static let SLOPED_OSM_OPTIONS_ONE = "SLOPED_OSM_OPTIONS_ONE".localized()
            static let SLOPED_OSM_OPTIONS_TWO = "SLOPED_OSM_OPTIONS_TWO".localized()
            static let SLOPED_OSM_OPTIONS_THREE = "SLOPED_OSM_OPTIONS_THREE".localized()
            static let SLOPED_OSM_OPTIONS_FOUR = "SLOPED_OSM_OPTIONS_FOUR".localized()
            
                static let SIDEWAlK_LEFT = "SIDEWAlK_LEFT".localized()
                static let SIDEWAlK_RIGHT = "SIDEWAlK_RIGHT".localized()
                static let SIDEWAlK_BOTH = "SIDEWAlK_BOTH".localized()
            
            static let PLEASE_CHOOSE_TEXT = "PLEASE_CHOOSE_TEXT".localized()
            static let MAXIMUM_SLOPED_CURB = "\("MAXIMUM_SLOPED_CURB".localized())"

            static let titlesKey = [AppConstants.ScreenSpecificConstant.FilterOptionScreen.titlesKey]
          
            //All traversable surfaces
            static let surfaceTypeOptions = [SURFACE_OSM_OPTION_ONE,SURFACE_OSM_OPTION_TWO,SURFACE_OSM_OPTION_THREE,SURFACE_OSM_OPTION_FOUR,SURFACE_OSM_OPTION_FIVE]
            static let surfaceTypeOptionsValues = [SURFACE_OSM_VALUE_ONE,SURFACE_OSM_VALUE_TWO,SURFACE_OSM_VALUE_THREE,SURFACE_OSM_VALUE_FOUR,SURFACE_OSM_VALUE_FIVE]
            
            static let inclineValues = [INCLINE_OSM_VALUE_ZERO,INCLINE_OSM_VALUE_ONE,INCLINE_OSM_VALUE_TWO,INCLINE_OSM_VALUE_THREE,INCLINE_OSM_VALUE_FOUR,INCLINE_OSM_VALUE_FIVE,INCLINE_OSM_VALUE_SIX,INCLINE_OSM_VALUE_SEVEN,INCLINE_OSM_VALUE_EIGHT,INCLINE_OSM_VALUE_NINE,INCLINE_OSM_VALUE_TEN,INCLINE_OSM_VALUE_ELEVEN]
            
            static let inclineOptions = [INCLINE_OSM_OPTION_ZERO,INCLINE_OSM_OPTION_ONE,INCLINE_OSM_OPTION_TWO,INCLINE_OSM_OPTION_THREE,INCLINE_OSM_OPTION_FOUR,INCLINE_OSM_OPTION_FIVE,INCLINE_OSM_OPTION_SIX,INCLINE_OSM_OPTION_SEVEN,INCLINE_OSM_OPTION_EIGHT,INCLINE_OSM_OPTION_NINE,INCLINE_OSM_OPTION_TEN,INCLINE_OSM_OPTION_ELEVEN]
            
            static let widthOptions = [WIDTH_OSM_OPTION_ONE,WIDTH_OSM_OPTION_TWO]
            static let widthValues = [WIDTH_OSM_VALUE_ONE,WIDTH_OSM_VALUE_TWO]
            
            static let slopedOptions = [SLOPED_OSM_OPTIONS_ONE,SLOPED_OSM_OPTIONS_TWO,SLOPED_OSM_OPTIONS_THREE,SLOPED_OSM_OPTIONS_FOUR]
            static let slopedValues = [SLOPED_OSM_VALUE_ONE,SLOPED_OSM_VALUE_TWO,SLOPED_OSM_VALUE_THREE,SLOPED_OSM_VALUE_FOUR]
            
            static let titles = [SURFACE_TYPE_TITLE,INCLINE_TITLE,WIDTH_TITLE]
            static let titlesOptions = [surfaceTypeOptions,inclineOptions,widthOptions]
            
            static let values = [surfaceTypeOptionsValues,inclineValues,widthValues]
            
            static let IMPROVE_ROUTING_TITLE = "IMPROVE_ROUTING_TITLE".localized()
            static let CAPTURE_QUESTION = "CAPTURE_QUESTION".localized()
            static let FEEDBACK_QUESTION = "FEEDBACK_QUESTION".localized()
            static let ROUTING_TEXT = "ROUTING_TEXT".localized()
            static let ENTER_LOCATION = "ENTER_LOCATION".localized()
            static let APPLY_TITLE = "APPLY_TITLE".localized()
            static let CLEAR_TITLE = "CLEAR_TITLE".localized()
            static let FINISHED_TITLE = "FINISHED_TITLE".localized()
        }
    }
    
    
    //MARK:- Common constants
    
    
    //MARK:- NSNotification Names
    struct NSNotificationNames {
        static let UPDATE_DRIVER_LOCATION = "updateDriverLocation"
        static let APP_BECOME_ACTIVE_NOTIFICATION = "APP_BECAME_ACTIVE_NOTIF"
        static let INTERNET_UNREACHABLE_NOTIFICATION = "INTERNET_UNREACHABLE_NOTIFICATION"
        static let INTERNET_RECHABLE_NOTIFICATION = NSNotification.Name(rawValue: "INTERNET_RECHABLE_NOTIFICATION")
         static let GET_SURVEY_WAY_NOTIFICATION = NSNotification.Name(rawValue: "GET_SURVEY_WAY_NOTIFICATION")
         static let GET_OSM_WAY_NOTIFICATION = NSNotification.Name(rawValue: "GET_OSM_WAY_NOTIFICATION")
        static let WAY_DATA_RECEIVED_NOTIFICATION = NSNotification.Name(rawValue: "WAY_DATA_RECEIVED_NOTIFICATION")
         static let OSM_WAY_DATA_RECEIVED_NOTIFICATION = NSNotification.Name(rawValue: "OSM_WAY_DATA_RECEIVED_NOTIFICATION")
        static let WAY_DATA_UPDATED_NOTIFICATION = NSNotification.Name(rawValue: "WAY_DATA_UPDATED_NOTIFICATION")
         static let OSM_WAY_DATA_UPDATED_NOTIFICATION = NSNotification.Name(rawValue: "OSM_WAY_DATA_UPDATED_NOTIFICATION")
        static let USER_LOG_OUT_NOTIFICATION = NSNotification.Name(rawValue: "USER_LOG_OUT_NOTIFICATION")
    }
    
    //Users/daffodil_pc/Documents/disabled_routing_ios/Disabled Routing/Resources/MARK:- NSNotification Names
    struct LeafletEvents {
        static let POLYLINE_TAPPED = "POLYLINE_TAPPED"
        static let NODE_TAPPED = "NODE_TAPPED"
        static let MAP_MOVE_END_EVENT = "MAP_MOVE_END_EVENT"
        static let MAP_ZOOM_LEVEL_CHANGED = "MAP_ZOOM_LEVEL_CHANGED"
        static let MAP_MOVE_START_EVENT = "MAP_MOVE_START_EVENT"
        static let APP_BECOME_ACTIVE_NOTIFICATION = "APP_BECAME_ACTIVE_NOTIF"
    }
    //MARK: Persistent user default data keys
    
    struct UserDefaultKeys{
        static let IS_ALREADY_LOGIN = "isAlreadyLogin"
        static let IS_ALREADY_VISITED = "IS_ALREADY_VISITED"
        static let DEVICE_TOKEN = "isAlreadyLogin"
        static let OAUTH_TOKEN = "OAUTH_TOKEN"
        static let OAUTH_TOKEN_SECRET = "OAUTH_TOKEN_SECRET"
        static let USER_ID = "userID"
        static let USER_NAME = "userName"
        

    }
    
    //MARK:- Date Formatter constants
    
    struct DateConstants {
        static let DOB_FORMAT = "dd/MM/yyyy"
        static let DOB_FORMAT_FROM_SERVER = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let TIME_FORMAT_IN_12_HOUR = "hh:mm a"
        
    }
}
