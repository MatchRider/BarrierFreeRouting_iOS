//
//  XMLServiceManagerExtension.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 14/03/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//
import Alamofire
import ObjectMapper
import AlamofireXmlToObjects
import Foundation
import EVReflection
import OAuthSwift
import SWXMLHash
extension ServiceManager
{
    /**
     Method is used for Get Request Api Call
     
     - parameter urlString:    URL String that is used for Api call
     - parameter successBlock: return success response
     - parameter failureBlock: return failure response
     */
    
    func requestGETWithURLXML<T:EVObject>(_ urlString:String , requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver , returningClass:T.Type)-> Void{
        
        self.delegate = responseCallBack
        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            //Iterating request header dictionary and adding into API Manager
            let url = URL(string:urlString)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
            //urlRequest.addValue("application/xml", forHTTPHeaderField: "Accept")
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
                   if urlString != "https://api.openstreetmap.org/api/0.6/map?bbox=8.672704,49.40659,8.720019,49.415246" {
          ServiceManager.sharedInstance.globalManager.adapter =  OAuthSwiftRequestAdapter(OAuthManager.shared.oauthswift)
            }
            self.dataTaskWithRequestAndSessionManager(ServiceManager.sharedInstance.globalManager.request(urlRequest), returningClass:returningClass)
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
    
    func requestGETWithParameterXML<T:EVObject>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject] , requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type)-> Void{
        
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
    func requestPOSTWithURLXML<T:EVObject>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject],requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type) ->Void{
        
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
            
            let urlRequest = Alamofire.request(urlString, method: .post,parameters:requestDictionary,headers: headers)
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
    func requestDELETEWithURLXML<T:EVObject>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject], requestHeader:[String:AnyObject] ,responseCallBack:ApiResponseReceiver , returningClass:T.Type) -> Void{
        
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
    func requestPUTWithURLXML<T:EVObject>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject], requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver , returningClass:T.Type) -> Void{
        
        self.delegate = responseCallBack
        
        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            
  
            
            let url = URL(string:urlString)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpBody = (requestDictionary["xml"] as! String).data(using: String.Encoding.utf8, allowLossyConversion: true)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/xml", forHTTPHeaderField: "Accept")
           // urlRequest.addValue(outhHeader, forHTTPHeaderField: AppConstants.APIRequestHeaders.AUTH_TOKEN)
            
            
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            ServiceManager.sharedInstance.globalManager.adapter =  OAuthSwiftRequestAdapter(OAuthManager.shared.oauthswift)
            self.dataTaskWithRequestAndSessionManager( ServiceManager.sharedInstance.globalManager.request(urlRequest), returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(errorObject: getNetworkError() as AnyObject)
        }
    }
    
    
    /**
     Calling Api with NSURLRequest and session Manager and fetching Response from server
     
     - parameter request:        NSURLRequest request used for interacting with server
     - parameter sessionManager: AFHTTPSessionManager that contains API Header and Content Type
     */
    fileprivate func dataTaskWithRequestAndSessionManager<T:EVObject>(_ request:DataRequest, returningClass: T.Type) -> Void {

        print("Start : \(Date())")
        request.responseObject { (response: DataResponse<T>) in
           
            print(response.response?.statusCode)
            print(response.error.debugDescription)
            print(response.result.error.debugDescription)
            
                if let responseData = response.response, responseData.statusCode >= 200 && responseData.statusCode < 300
                {
                    if let result = response.data {
                        self.delegate?.onSuccessXML(result)
                    }
                }
                else
                {
                    if let result = response.data
                    {
                        //if let _ = response.response?.statusCode {
                            
                        self.delegate?.onError(errorObject:result as AnyObject)
//                        } else {
//                            self.dataTaskWithRequestAndSessionManager(request, returningClass: T.self)
//                        }
                    }
//                    let error = NSError(domain: "", code: (response.response?.statusCode)!, userInfo: nil)
//                    self.delegate?.onError(errorObject:error)
            }
        }
        
        
//        request.response { (response) in
//
//            if let responseData = response.response, responseData.statusCode >= 200 && responseData.statusCode < 300
//            {
//                if let result = response.data
//                {
//                    self.delegate?.onSuccessXML(result)
//                }
//            }
//            else
//            {
//
////                let error = NSError(domain: "", code: (response.response?.statusCode)!, userInfo: nil)
////                let result = Mapper<ErrorResponse>().map(JSONString: self.getJsonStringFor(dictionary: response.result.value ?? [] ))
////                self.delegate?.onError(error , errorObject:result as AnyObject?)
//            }
//        }
        
    }
}
