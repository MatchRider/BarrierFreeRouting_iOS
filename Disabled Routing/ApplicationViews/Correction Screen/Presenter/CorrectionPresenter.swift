//
//  CorrectionPresenter.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 2/20/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import EVReflection
import AEXML
import SwiftKeychainWrapper
class CorrectionPresenter: ResponseCallback{
    
    //MARK:- CorrectionPresenter local properties
    internal weak var correctionDelegate             : CorrectionViewDelgate?
    var isCreateChangeSetCalled = false
    var isUpdateOSMElementCalled = false
    var isUpdateWayServerCalled = false
    var isGetElementCalled = false
    var isNodeCreateElementCalled = false
    var isWayCreateElementCalled = false
    var wayData : WayData!
    var nodeData : NodeReference!
    var currentIndex = -1
    var changeSetID = ""
    var elementType : ElementType = .way
    private var shouldShowLoaderOnScreen = true
    //MARK:- Constructor
    init(delegate responseDelegate:CorrectionViewDelgate) {
        self.correctionDelegate = responseDelegate
    }
    
    //MARK:- ResponseCallback delegate methods
    
    func servicesManagerSuccessResponse<T:Mappable> (responseObject : T){
        self.correctionDelegate?.hideLoader()
        if let response = responseObject as? WayResponseModel,response.status == true
        {
            if self.currentIndex == -1 || self.elementType == .node {
                self.correctionDelegate?.didUpdateElementDataOnServer(withResponseModel:response)
            } else {
                self.updateNextNode()
            }
        } else if let response = responseObject as? WayResponseModel,response.status == false {
            self.correctionDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.DATA_NOT_SAVED)
            //  self.correctionDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: response.error![0].message ?? AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
        }
    }
    func servicesManagerSuccessResponseXML<T>(responseObject: T) {
        self.correctionDelegate?.hideLoader()
        if isCreateChangeSetCalled {
            isCreateChangeSetCalled = false
            self.changeSetID = String(data: (responseObject as! Data), encoding: String.Encoding.utf8)!
            self.correctionDelegate?.didCreatedChangeSet(withResponseModel:self.changeSetID )
        } else if isUpdateOSMElementCalled {
            isUpdateOSMElementCalled = false
            self.correctionDelegate?.didUpdateWayDataOSM(forType:elementType,andResponseModel: String(data: (responseObject as! Data), encoding: String.Encoding.utf8)!)
        }
        else if isGetElementCalled {
            isGetElementCalled = false
            if let responseData = responseObject as? Data, let elementData = OSM(xmlData: responseData),let xmlData = try? AEXMLDocument(xml: responseData) {
                self.correctionDelegate?.didGetDataOSM(withResponseModel: elementData, andXMLData: xmlData)
            }
        } else if isNodeCreateElementCalled {
            isNodeCreateElementCalled = false
            
            let osmNodeId = String(data: (responseObject as! Data), encoding: String.Encoding.utf8)!
            var updatedNode : NodeReference!
            if elementType == .way {
                 updatedNode = self.wayData.nodeReference![self.currentIndex]
            } else {
                updatedNode = nodeData
            }
                updatedNode.osmNodeId = osmNodeId
                self.sendUpdateElementRequestOnServer(withInformationRequest: updatedNode,forType: .node)
        } else if isWayCreateElementCalled {
            isWayCreateElementCalled = false
            let osmWayId = String(data: (responseObject as! Data), encoding: String.Encoding.utf8)!
                self.wayData.osmWayId = osmWayId
            self.sendUpdateElementRequestOnServer(withInformationRequest: self.wayData,forType: .way)
        }
    }
    func servicesManagerError(error : AnyObject){
        isCreateChangeSetCalled = false
        isUpdateOSMElementCalled = false
        isUpdateWayServerCalled = false
        isGetElementCalled = false
        isNodeCreateElementCalled = false
        isWayCreateElementCalled = false
        self.correctionDelegate?.hideLoader()
        if let errorData = error as? Data,let errorMessage = String(data: errorData, encoding: String.Encoding.utf8) {
            self.correctionDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage:errorMessage)//AppConstants.ErrorMessages.DATA_NOT_SAVED)
        }
    }
    
    
    //MARK:- Methods to call server
    
    /**
     This method is used to send direction request to business layer with valid Request model
     - returns : Void
     */
    func sendCreateChangeSetRequest() -> Void{
        self.correctionDelegate?.showLoader()
        var captureOptionRequestModel : CorrectionOptionRequestModel!
        
        let createChangeSetRequest = AEXMLDocument()
        let osm = createChangeSetRequest.addChild(name: "osm")
        let changeset = osm.addChild(name: "changeset")
        changeset.addChild(name: "tag",attributes: ["k":"created_by","v":"Barrierefrei Projekt"])
         changeset.addChild(name: "tag",attributes: ["k":"comment","v":AppConstants.App.APP_INFO])
        captureOptionRequestModel = CorrectionOptionRequestModel.Builder().setXMLRequest(createChangeSetRequest.xml)
            .build()
        self.isCreateChangeSetCalled = true
        CorrectionOptionAPIRequest().makeAPIRequestForCreateChangeRequest(withReqFormData: captureOptionRequestModel, responseCallback: self)
    }
    //MARK:- Methods to call server
    
    /**
     This method is used to send create node request to business layer with valid Request model
     - returns : Void
     */
    func sendUpdateElementRequestOnOSM<T:Mappable>(withInformationRequest infoRequest:T,xmlData:AEXMLDocument,changeSetId:String,andVersion version:String) -> Void {
        self.correctionDelegate?.showLoader()
        var correctionRequestModel : CorrectionOptionRequestModel!
        if self.elementType == .way {
            let wayData = infoRequest as! WayData
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setXMLRequest(self.createUpdateWayXMLRequest(wayData,changeSetId: changeSetId,version:version, xmlData: xmlData)).setWayId(wayData.osmWayId!).setElementType(self.elementType)
                .build()
        } else {
            let nodeData = infoRequest as! NodeReference
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setXMLRequest(self.createUpdateNodeXMLRequest(nodeData,changeSetId: changeSetId,version:version)).setNodeId(nodeData.osmNodeId!).setElementType(self.elementType)
                .build()
        }
        
        
        self.isUpdateOSMElementCalled = true
         CorrectionOptionAPIRequest().makeAPIRequest(withReqFormData: correctionRequestModel, responseCallback: self)
    }
    func sendUpdateElementRequestOnServer<T:Mappable>(withInformationRequest infoRequest:T,forType type:ElementType) -> Void {
        self.correctionDelegate?.showLoader()
        var correctionRequestModel : CorrectionOptionRequestModel!
        var name = "Hürdenlose Navigation"
        if let userName = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.USER_NAME),let userID = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.USER_ID) {
            name = "\(userName)_\(userID)"
        }
        
        if type == .way {
           let way = (infoRequest as! WayData)
           let nonEmptyAttributes = way.attributes?.filter{$0.value != "" && $0.key != "" && $0.isValid != ""}
            way.attributes = nonEmptyAttributes
            var wayData = way.dictionaryRepresentation()
            wayData.removeValue(forKey: "Coordinates")
            wayData.removeValue(forKey: "Color")
            wayData.removeValue(forKey: "NodeReference")

            correctionRequestModel = CorrectionOptionRequestModel.Builder().setWayData(wayData).setUserData(name).setElementType(.way)
                .build()
        } else {
            let nodeData = infoRequest as! NodeReference
            if nodeData.attributes == nil {
                nodeData.attributes = []
            }
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setNodeData(nodeData.dictionaryRepresentation()).setUserData(name).setElementType(.node)
                .build()
        }
        
        
        //  self.isUpdateWayCalled = true
         CorrectionOptionAPIRequest().makeAPIRequestForElementUpdateInformation(withReqFormData: correctionRequestModel, responseCallback: self)
    }
    func sendGetElementDataFromOSM(withID id:String,forType type:ElementType) -> Void{
        self.correctionDelegate?.showLoader()
        var correctionRequestModel :CorrectionOptionRequestModel!
        if self.elementType == .way {
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setWayId(id).setElementType(self.elementType)
                .build()
        } else {
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setNodeId(id).setElementType(self.elementType)
                .build()
        }
        
        self.isGetElementCalled = true
         CorrectionOptionAPIRequest().makeAPIRequestForGetWayData(withReqFormData: correctionRequestModel, responseCallback: self)
    }
    private func createUpdateWayXMLRequest(_ infoRequest:WayData,changeSetId:String,version:String,xmlData:AEXMLDocument)->String
    {
        
        let createNodeRequest = AEXMLDocument()
        let osm = createNodeRequest.addChild(name: "osm")
        let way = osm.addChild(name: "way",attributes: ["id":infoRequest.osmWayId!,"changeset":changeSetId,"version":version])
        if infoRequest.isOSMWay {
            for attribute in infoRequest.attributes! where attribute.value != "" {
//                if attribute.value != "" {
                    way.addChild(name: "tag",attributes: ["k":attribute.key!,"v":attribute.value!])
                //}
            }
        } else {
            for attribute in infoRequest.attributes! where attribute.isValid == "true"  {
//                if (attribute.key == "incline" && attribute.isValid == "true") || (attribute.key == "width" && attribute.isValid == "true") || (attribute.key == "surface" && attribute.isValid == "true")
//                {
                    way.addChild(name: "tag",attributes: ["k":attribute.key!,"v":attribute.value!])
               // }
            }
        }
        
        for nodeRef in (xmlData["osm"]["way"]["nd"].all)! {
            way.addChild(nodeRef)
        }
        return createNodeRequest.xml
    }
    private func createUpdateNodeXMLRequest(_ infoRequest:NodeReference,changeSetId:String,version:String)->String {
        
        let createNodeRequest = AEXMLDocument()
        let osm = createNodeRequest.addChild(name: "osm")
        let node = osm.addChild(name: "node",attributes: ["id":infoRequest.osmNodeId!,"changeset":changeSetId,"version":version,"lat":infoRequest.lat!,"lon":infoRequest.lon!])
        
        for attribute in infoRequest.attributes! {
            if attribute.key == "kerb:height" && attribute.isValid == "true"
            {
                node.addChild(name: "tag",attributes: ["k":attribute.key!,"v":attribute.value!])
            }
        }
        return createNodeRequest.xml
    }
}
