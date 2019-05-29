import UIKit
import Alamofire
import ObjectMapper

class ServiceManager  {
    
    static let sharedInstance = ServiceManager()
    private init() {
         globalManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
    
    internal(set) var delegate : ApiResponseReceiver?
    
    private(set) var globalManager:SessionManager!
    
    //    private override init() {
    //
    //    }
    
//    internal func sessionManager() -> SessionManager
//    {
//        if globalManager==nil
//        {
//           
//        }
//        return globalManager
//    }
    
    /**
     This method cancel all the Api calls , currently running
     */
    
    func cancelAllOperations() ->Void
    {
        globalManager.session.invalidateAndCancel()
    }
    
    
    /**
     This method cancel Api call specific to url
     
     - parameter urlString: Url String that is used for Api call
     */
    
    func cancelTaskWithURL(_ urlString:String) ->Void
    {
        globalManager.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                var tasks = dataTasks as [URLSessionTask]
                tasks.append(contentsOf: uploadTasks as [URLSessionTask])
                tasks.append(contentsOf: downloadTasks as [URLSessionTask])
                for task in tasks{
                    //Checking task URL if it's matches with URL we cancel that specific task
                    
                    if((task.originalRequest!.url?.absoluteString.contains(urlString)) != nil){
                        task.cancel()
                    }
                }
        }
    }
    
    /**
     This method checks whether API is in Progress or not
     
     - parameter urlString: Url String that is used for Api call
     
     - returns: Returning true or false depend whether API is running or not
     */
    
//    func isInProgress(_ urlString:String) ->Bool{
//        globalManager.session.getTasksWithCompletionHandler
//            {
//                (dataTasks, uploadTasks, downloadTasks) -> Void in
//                var tasks = dataTasks as [URLSessionTask]
//                tasks.append(contentsOf: uploadTasks as [URLSessionTask])
//                tasks.append(contentsOf: downloadTasks as [URLSessionTask])
//                for task in tasks{
//                    //Checking task URL if it's matches with URL we cancel that specific task
//                    if((task.originalRequest!.url?.absoluteString.contains(urlString)) != nil){
//                        if(task.state == .running){
//                            return true
//                        }
//                    }
//                }
//        }
//        return false
//    }
    
    /**
     This method return NSError object in case if internet connection is not available
     
     - returns: NSError Object
     */
    
    internal func getNetworkError() -> [String:String] {
        return ["IsError": "network_error", "Code": "-1009", "Message":AppConstants.ErrorMessages.PLEASE_CHECK_YOUR_INTERNET_CONNECTION]
    }
    
    /**
     Method is used for Get Request Api Call
     
     - parameter urlString:    URL String that is used for Api call
     - parameter successBlock: return success response
     - parameter failureBlock: return failure response
     */
    
    func requestGETWithURL<T:Mappable>(_ urlString:String , requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver , returningClass:T.Type)-> Void{
        
        self.delegate = responseCallBack
        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            var headers : HTTPHeaders = [:]
            for (key, value) in requestHeader {
                headers[key] = (value as? String)!
            }
            //Add default api key in header
             headers[AppConstants.APIRequestHeaders.API_KEY] = AppConstants.APIRequestHeaders.API_KEY_VALUE
             headers["Accept"] = "application/json"

            let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var error:NSError?
            let urlRequest = Alamofire.request(urlEncoded!, method: .get, headers: headers)
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(urlRequest, returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }
    
    
    /**
     Method is used for Get Request Api Call with parameter
     
     - parameter urlString:         URL String that is used for Api call
     - parameter requestDictionary: dictionary used as a parameter
     - parameter successBlock:      return success response
     - parameter failureBlock:      return failure response
     */
    
    func requestGETWithParameter<T:Mappable>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject] , requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type)-> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            var headers : HTTPHeaders = [:]
            for (key, value) in requestHeader {
                headers[key] = (value as? String)!
            }
            //Add default api key in header
            headers[AppConstants.APIRequestHeaders.API_KEY] = AppConstants.APIRequestHeaders.API_KEY_VALUE
            headers["Accept"] = "application/json"
            
            let urlRequest = Alamofire.request(urlString, method: .get,parameters:requestDictionary,headers: headers)
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(urlRequest, returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }
    

//    /**
//     Method is used for Post Request Api Call with parameter
//
//     - parameter urlString:         URL String that is used for Api call
//     - parameter requestDictionary: dictionary used as a parameter
//     - parameter successBlock:      return success response
//     - parameter failureBlock:      return failure response
//     */
//
    func requestPOSTWithURL<T:Mappable>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject],requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type) ->Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            var headers : HTTPHeaders = [:]
            for (key, value) in requestHeader {
                headers[key] = (value as? String)!
            }
            //Add default api key in header
            headers["Content-Type"] = "application/json"
            
            let urlRequest = Alamofire.request(urlString, method: .post,parameters:requestDictionary,encoding: JSONEncoding.default,headers: headers)
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(urlRequest, returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }

//    /**
//     Method is used for Delete Request Api Call with parameter
//
//     - parameter urlString:         URL String that is used for Api call
//     - parameter requestDictionary: dictionary used as a parameter
//     - parameter successBlock:      return success response
//     - parameter failureBlock:      return failure response
//     */
//
    func requestDELETEWithURL<T:Mappable>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject], requestHeader:[String:AnyObject] ,responseCallBack:ApiResponseReceiver , returningClass:T.Type) -> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            var headers : HTTPHeaders = [:]
            for (key, value) in requestHeader {
                headers[key] = (value as? String)!
            }
            //Add default api key in header
            headers[AppConstants.APIRequestHeaders.API_KEY] = AppConstants.APIRequestHeaders.API_KEY_VALUE
            headers["Accept"] = "application/json"
            
            let urlRequest = Alamofire.request(urlString, method: .delete,parameters:requestDictionary,headers: headers)
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(urlRequest, returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }
//
//    /**
//     Method is used for Put Request Api Call with parameter
//
//     - parameter urlString:         URL String that is used for Api call
//     - parameter requestDictionary: dictionary used as a parameter
//     - parameter successBlock:      return success response
//     - parameter failureBlock:      return failure response
//     */
//
    func requestPUTWithURL<T:Mappable>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject], requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver , returningClass:T.Type) -> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            var headers : HTTPHeaders = [:]
            for (key, value) in requestHeader {
                headers[key] = (value as? String)!
            }
            //Add default api key in header
            headers[AppConstants.APIRequestHeaders.API_KEY] = AppConstants.APIRequestHeaders.API_KEY_VALUE
            headers["Accept"] = "application/json"
            
            let urlRequest = Alamofire.request(urlString, method: .put,parameters:requestDictionary,headers: headers)
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(urlRequest, returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }
//
//    /**
//     Method is used for Multipart Request Api Call with parameter
//
//     - parameter urlString:            URL String that is used for Api call
//     - parameter imageData:            data uploads in multipart
//     - parameter andRequestDictionary: dictionary used as a parameter
//     - parameter imageName:            image that has to be uploaded
//     - parameter successBlock:         return success response
//     - parameter failureBlock:         return failure response
//     - parameter progressBlock:        return progress response
//     */
//
//    func requestMultipartRequestWithURL(_ urlString:String, andImageData imageData:Data, andRequestDictionary:[String : Data?],requestHeader:[String:AnyObject], withImageName imageName:String , withSuccessBlock successBlock:@escaping (_ response:AnyObject) ->Void, andFailureBlock failureBlock:@escaping (_ error:NSError) ->Void, andProgressBlock progressBlock:@escaping (_ progress:Double) -> Void){
//
//
//        // Checking the rechability of Network
//        if ReachabilityManager.shared.isNetworkAvailable {
//
//            // Instantiate session manager Object
//            let manager:AFHTTPSessionManager = self.sessionManager()
//
//            //Iterating request header dictionary and adding into API Manager
//            for (key, value) in requestHeader {
//                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
//            }
//
//            //Add default api key in header
//            manager.requestSerializer.setValue(AppConstants.APIRequestHeaders.API_KEY_VALUE, forHTTPHeaderField: AppConstants.APIRequestHeaders.API_KEY)
//
//            // Creating Immutable Multipart POST NSURL Request
//            let request:URLRequest = manager.requestSerializer.multipartFormRequest(withMethod: "POST", urlString: urlString, parameters: nil, constructingBodyWith: { (formData:AFMultipartFormData!) -> Void in
//
//                formData.appendPart(withFileData: imageData as Data, name: imageName, fileName: "file.jpg", mimeType: "image/jpeg")
//
//            }, error: nil) as URLRequest
//
//
//            var uploadTask: URLSessionUploadTask
//
//            // Calling Api with NSURLRequest and upload progress
//
//            uploadTask = manager.uploadTask(withStreamedRequest: request as URLRequest, progress: { (_ uploadProgress: Progress)  in
//
//                DispatchQueue.main.async(execute: {
//                    progressBlock (uploadProgress.fractionCompleted)
//                })
//
//            }, completionHandler: { (_ response: URLResponse, _ responseObject: Any?, _ error: Error?) in
//                // Checking whether API Response contains Success response or Error Response
//                if( (error == nil) && (responseObject != nil)){
//                    successBlock(responseObject! as AnyObject)
//
//                }else {
//                    failureBlock (error! as NSError)
//                }
//
//            })
//
//            //Resuming Uploading
//            uploadTask.resume()
//        }
//        else{
//            // Generating common network error
//            failureBlock(getNetworkError())
//        }
//    }
//
//    /**
//     Method is used for Multipart Request Api Call with parameter
//
//     - parameter urlString:            URL String that is used for Api call
//     - parameter imageData:            data uploads in multipart
//     - parameter andRequestDictionary: dictionary used as a parameter
//     */
//
//    func requestMultipartGetRequestWithURL<T:Mappable>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject],requestHeader:[String:AnyObject] ,imageData:Data, responseCallBack:ApiResponseReceiver , returningClass:T.Type) ->Void {
//
//        self.delegate = responseCallBack
//
//        // Checking the rechability of Network
//        if ReachabilityManager.shared.isNetworkAvailable {
//
//            // Instantiate session manager Object
//            let manager:AFHTTPSessionManager = self.sessionManager()
//
//            //   Iterating request header dictionary and adding into API Manager
//            for (key, value) in requestHeader {
//                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
//
//            }
//
//            //Add default api key in header
//            manager.requestSerializer.setValue(AppConstants.APIRequestHeaders.API_KEY_VALUE, forHTTPHeaderField: AppConstants.APIRequestHeaders.API_KEY)
//
//            //Setting multipart request Header
//            //            manager.requestSerializer.setValue("multipart/form-data", forKey: "Content-Type")
//
//            //            let imageData:Data = requestDictionary["file-data"] as! Data
//            //            let fileName:String  = "disabled_routing"
//            //            let fileType:String  = requestDictionary["file-type"] as! String
//            //
//            //            var requestDic = requestDictionary
//            //
//            //            requestDic.removeValue(forKey: "file_data")
//
//            // Creating Immutable Multipart POST NSURL Request
//            let request:URLRequest = manager.requestSerializer.multipartFormRequest(withMethod: "POST", urlString: urlString, parameters: nil, constructingBodyWith: { (formData:AFMultipartFormData!) -> Void in
//
//                formData.appendPart(withFileData: imageData, name: "file", fileName: "file", mimeType: "image/jpeg")
//
//            }, error: nil) as URLRequest
//
//
//            var uploadTask: URLSessionUploadTask
//
//            // Calling Api with NSURLRequest and upload progress
//
//            uploadTask = manager.uploadTask(withStreamedRequest: request as URLRequest, progress: { (_ uploadProgress: Progress)  in
//
//
//            }, completionHandler: { (_ response: URLResponse, _ responseObject: Any?, _ error: Error?) in
//                // Checking whether API Response contains Success response or Error Response
//
//                // Checking whether API Response contains Success response or Error Response
//                if( (error == nil) && (responseObject != nil)){
//
//                    let result = Mapper<T>().map(JSONString: self.getJsonStringFor(dictionary: responseObject ?? ""))
//                    self.delegate?.onSuccess(result!)
//
//                }else {
//                    self.delegate?.onError(error! as NSError , errorObject: responseObject as AnyObject?)
//                }
//            })
//
//            //Resuming Uploading
//            uploadTask.resume()
//        }
//        else{
//            self.delegate?.onError(self.getNetworkError() , errorObject: nil)
//        }
//    }
//
    
    /**
     Calling Api with NSURLRequest and session Manager and fetching Response from server
     
     - parameter request:        NSURLRequest request used for interacting with server
     - parameter sessionManager: AFHTTPSessionManager that contains API Header and Content Type
     */
    fileprivate func dataTaskWithRequestAndSessionManager<T:Mappable>(_ request:DataRequest, returningClass: T.Type) -> Void {
        
       request.responseJSON() { response in
        if let responseData = response.response
        {
            if (responseData.statusCode) >= 200 && (responseData.statusCode) < 300
            {
                let value = response.value
                if let arrayObject = value as? [Any]
                {
                    let result = Mapper<T>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: self.getDictionaryFromArray(array: arrayObject)))
                    self.delegate?.onSuccess(result!)
                }
                else
                {
                    let result = Mapper<T>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: value ?? [] ))
                    self.delegate?.onSuccess(result!)
                }
            }
            else
            {
                if let errorObject = response.result.value
                {
                    self.delegate?.onError(errorObject: errorObject as AnyObject)
                }
            }
        }
    }
    }
    
    
    class func getJsonStringFor(dictionary:Any) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject:dictionary, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            return dataString
            
        } catch {
            
        }
        return ""
    }
    
    private func getDictionaryFromArray(array:[Any]) -> [String:Any] {
        let  dictionary = ["list" : array]
        return dictionary
    }
    func fetchRefreshToken() ->Void {
        //   let urlString:String = Constants.URL.BASE_URL + "/users/refreshToken"
        //        self.requestGETWithURL(urlString, requestHeader: ["Content-Type" : "application/json"], responseCallBack: ApiResponseReceiver, returningClass: T.Type)
    }
    
    
}

