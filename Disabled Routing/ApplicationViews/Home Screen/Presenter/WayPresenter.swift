//
//  WayPresenter.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 7/19/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import ObjectMapper
import SWXMLHash
class WayPresenter: ResponseCallback{
    
    //MARK:- WayPresenter local properties
    private weak var wayViewDelegate             : WayViewDelegate?

    //MARK:- Constructor
    init(delegate wayDelegate: WayViewDelegate) {
        self.wayViewDelegate = wayDelegate
    }
    //MARK:- ResponseCallback delegate methods
    
    func servicesManagerSuccessResponse<T:Mappable> (responseObject : T){
         self.wayViewDelegate?.hideLoader()
        if let response = responseObject as? WayResponseModel,response.status == true {
            self.wayViewDelegate?.receivedWayDataSuccessfully(withResponseModel:responseObject as! WayResponseModel)
        }
        else if let response = responseObject as? WayResponseModel,response.status == false {
            self.wayViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: response.error![0].message ?? AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
        }
    }
    func servicesManagerSuccessResponseXML<T>(responseObject: T) {
       DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        let xml = SWXMLHash.lazy(responseObject as! Data)
        let tempXml = SWXMLHash.lazy(responseObject as! Data)
        let sideWalkWays = xml["osm"]["way"].all.filter({ (elem) -> Bool in
            for child in elem.children {
                if child.element!.name == "tag" {
                    let key = child.element!.attribute(by: "k")?.text
                    let value = child.element!.attribute(by: "v")?.text
                    //For sidewalk as seperate way
                    var isHighwayEqualsFootway = false
                    var isFootwayEqualsSidewalk = false
                    
                    //For Sidewalk part of highway
                    var doContainSidewalk = false
                    
                    if key == "footway" && value == "sidewalk" {
                        isFootwayEqualsSidewalk = true
                    }
                    
                    if key == "highway" && value == "footway" {
                        isHighwayEqualsFootway = true
                    }
                    
                    if key == "sidewalk" && value != "no" {
                        doContainSidewalk = true
                    }
                    let isSidewalk = doContainSidewalk || (isFootwayEqualsSidewalk && isHighwayEqualsFootway)
                    if isSidewalk {
                        return isSidewalk
                    }
                    
                }
            }
            return false
        })
        var allNodeIds = [String]()
        for element in sideWalkWays {
            for child in element.children {
                if child.element?.name == "nd" {
                    allNodeIds.append((child.element?.attribute(by: "ref")!.text)!)
                }
            }
        }
        
        var allNodeList = tempXml["osm"]["node"].all.filter({ (elem) -> Bool in
          var isKerbAvailable = false
            if elem.children.count != 0 {
                for child in elem.children {
                    if child.element!.name == "tag" {
                        let key = child.element!.attribute(by: "k")?.text
                        if key == "kerb:height" {
                            isKerbAvailable = true
                        }
                    }
                }
            }
            return allNodeIds.contains((elem.element?.attribute(by: "id")!.text)!) || isKerbAvailable
            
        })
        
        
        
        
     
        allNodeList.append(contentsOf: sideWalkWays)
        let xmlFiltered = "<osm>\(String(allNodeList.flatMap{$0.description}))</osm>"
            if let elementData = OSMServer(xmlString:xmlFiltered) {
                let nativeModel = elementData.toWayResponseModel()
                let ways = nativeModel.ways
                let nodes = nativeModel.nodes
                DispatchQueue.main.sync {
                    self?.wayViewDelegate?.receivedOSMServerDataSuccessfully(withResponseModel: ways!, andNodeReferences: nodes)
                }
            }
        }
       
       
    }
    func servicesManagerError(error : AnyObject) {
        self.wayViewDelegate?.hideLoader()
        if let errorObject = Mapper<WayError>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: error)),let errorMessage = errorObject.message {
            self.wayViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: errorMessage)
        }
        else {
            self.wayViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
        }
    }
    
    
    //MARK:- Methods to call server
    
    /**
     This method is used to send way request to business layer with valid Request model
     - returns : Void
     */
    func sendWayDataRequest() -> Void {
          WayAPIRequest().makeAPIRequest(withReqFormData: WayRequestModel.Builder().build(), responseCallback: self)
    }
    func sendOSMDataRequest() -> Void {
        WayAPIRequest().makeAPIRequestForOSMRequest(withReqFormData:  WayRequestModel.Builder().build(), responseCallback: self)
    }
}
