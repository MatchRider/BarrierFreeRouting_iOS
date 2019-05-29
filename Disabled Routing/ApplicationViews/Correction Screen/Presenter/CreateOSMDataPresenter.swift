//
//  CreateOSMDataPresenter.swift
//  Disabled Routing
//
//  Created by Daffodil_pc on 04/10/18.
//  Copyright © 2018 Daffodil_pc. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import EVReflection
import AEXML
import SwiftKeychainWrapper
extension CorrectionPresenter {
    
    func createWayOnOSMServer(withData wayData:WayData) {
        self.wayData = wayData
        guard let nodes = self.wayData.nodeReference else {
            return
        }
        for (index,node) in nodes.enumerated() {
            if let nodeid = node.osmNodeId,nodeid == "" {
             self.currentIndex = index
                
                self.sendCreateElementRequestOnOSM(withInformationRequest: node, changeSetId: self.changeSetID, ofType: .node)
                break
            }
        }
        if self.currentIndex == -1 {
            self.sendCreateElementRequestOnOSM(withInformationRequest: self.wayData, changeSetId: self.changeSetID, ofType: .way)
        }
    }
    
    func updateNextNode() {
        guard let nodes = self.wayData.nodeReference else {
            return
        }
        if self.currentIndex < nodes.count-1 {
            print("self.currentIndex : \(self.currentIndex)")
            self.currentIndex = self.currentIndex+1
            self.sendCreateElementRequestOnOSM(withInformationRequest: nodes[self.currentIndex], changeSetId: self.changeSetID, ofType: .node)
        } else {
            self.sendCreateElementRequestOnOSM(withInformationRequest: self.wayData, changeSetId: self.changeSetID, ofType: .way)
        }
    }
    
    func sendCreateElementRequestOnOSM<T:Mappable>(withInformationRequest infoRequest:T,changeSetId:String,ofType type:ElementType) -> Void {
        self.correctionDelegate?.showLoader()
        var correctionRequestModel : CorrectionOptionRequestModel!
        if type == .way {
            self.currentIndex = -1
            let wayData = infoRequest as! WayData
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setXMLRequest(self.createNewWayXMLRequest(wayData,changeSetId: changeSetId)).setWayId(wayData.osmWayId!).setElementType(self.elementType)
                .build()
             self.isWayCreateElementCalled = true
        } else {
            let nodeData = infoRequest as! NodeReference
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setXMLRequest(self.createNewNodeXMLRequest(nodeData,changeSetId: changeSetId)).setNodeId(nodeData.osmNodeId!).setElementType(type)
                .build()
            self.isNodeCreateElementCalled = true
        }
         CorrectionOptionAPIRequest().makeCreateElementAPIRequest(withReqFormData: correctionRequestModel, responseCallback: self)
    }
    func sendCreateElementRequestOnServer<T:Mappable>(withInformationRequest infoRequest:T) -> Void {
        self.correctionDelegate?.showLoader()
        var correctionRequestModel : CorrectionOptionRequestModel!
        var name = "Hürdenlose Navigation"
        if let userName = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.USER_NAME),let userID = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.USER_ID) {
            name = "\(userName)_\(userID)"
        }
        
        if self.elementType == .way {
            var wayData = (infoRequest as! WayData).dictionaryRepresentation()
            wayData.removeValue(forKey: "Coordinates")
            wayData.removeValue(forKey: "Color")
            wayData.removeValue(forKey: "NodeReference")
            
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setWayData(wayData).setUserData(name).setElementType(self.elementType)
                .build()
        } else {
            let nodeData = (infoRequest as! NodeReference).dictionaryRepresentation()
            correctionRequestModel = CorrectionOptionRequestModel.Builder().setNodeData(nodeData).setUserData(name).setElementType(self.elementType)
                .build()
        }
        
        
        //  self.isUpdateWayCalled = true
         CorrectionOptionAPIRequest().makeAPIRequestForElementUpdateInformation(withReqFormData: correctionRequestModel, responseCallback: self)

    }
    private func createNewWayXMLRequest(_ infoRequest:WayData,changeSetId:String)->String
    {
        let createNodeRequest = AEXMLDocument()
        let osm = createNodeRequest.addChild(name: "osm")
        let way = osm.addChild(name: "way",attributes:["changeset":changeSetId])
        guard let attributes = infoRequest.attributes else {
            return createNodeRequest.xml
        }
        for attribute in infoRequest.attributes! where attribute.isValid == "true"  {
            //                if (attribute.key == "incline" && attribute.isValid == "true") || (attribute.key == "width" && attribute.isValid == "true") || (attribute.key == "surface" && attribute.isValid == "true")
            //                {
            way.addChild(name: "tag",attributes: ["k":attribute.key!,"v":attribute.value!])
            // }
        }
        for nodeRef in infoRequest.nodeReference! {
            way.addChild(name: "nd",attributes: ["ref":nodeRef.osmNodeId!])
        }
        return createNodeRequest.xml
    }
    private func createNewNodeXMLRequest(_ infoRequest:NodeReference,changeSetId:String)->String
    {
        
        let createNodeRequest = AEXMLDocument()
        let osm = createNodeRequest.addChild(name: "osm")
        let node = osm.addChild(name: "node",attributes: ["changeset":changeSetId,"lat":infoRequest.lat!,"lon":infoRequest.lon!])
        
        guard let attributes = infoRequest.attributes else {
            return createNodeRequest.xml
        }
        for attribute in attributes {
            if attribute.key == "kerb:height" && attribute.isValid == "true"
            {
                node.addChild(name: "tag",attributes: ["k":attribute.key!,"v":attribute.value!])
            }
        }
        return createNodeRequest.xml
    }
}
