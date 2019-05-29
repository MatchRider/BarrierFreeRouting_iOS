//
//  WayDetails.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 30/08/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class WayDetails {
    static let shared = WayDetails()
    var wayData : WayResponseModel?
    var nodeData : [NodeReference]?
    
    var osmWayData : WayResponseModel?
    var osmNodeData : [NodeReference]?
    
    private var presenterWay:WayPresenter!
    private init() {
        presenterWay = WayPresenter(delegate: self)
    }
    func getWayData() {
       // self.showLoader()
        presenterWay.sendWayDataRequest()
    }
    func getOSMData() {
        // self.showLoader()
        presenterWay.sendOSMDataRequest()
    }
    
    
}
extension WayDetails:WayViewDelegate {
    func receivedOSMServerDataSuccessfully(withResponseModel osmResponseModel: WayResponseModel, andNodeReferences nodeReferences: [NodeReference]) {
        WayDetails.shared.osmWayData = osmResponseModel
        WayDetails.shared.osmNodeData = nodeData(fromWayData: nil, orNodeReferences: nodeReferences)
        NotificationCenter.default.post(name: AppConstants.NSNotificationNames.OSM_WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
    }
    
    func receivedWayDataSuccessfully(withResponseModel wayDataResponseModel: WayResponseModel) {
       // self.hideLoader()
        WayDetails.shared.wayData = wayDataResponseModel
        let array  = wayDataResponseModel.way?.filter{$0.osmWayId != ""}.compactMap{$0.osmWayId}
        WayDetails.shared.nodeData = nodeData(fromWayData: wayDataResponseModel, orNodeReferences: nil)
        NotificationCenter.default.post(name: AppConstants.NSNotificationNames.WAY_DATA_RECEIVED_NOTIFICATION, object: nil)
    }
    
    private func filterSideWalkWays(fromWayData wayData:WayResponseModel) {
       
        for way in wayData.way! {
            for attribute in way.attributes! {
                //For Sidewalk as seperate geometry
                
            }
        }
        
    }
    private func nodeData(fromWayData wayData:WayResponseModel?,orNodeReferences nodeReference :[NodeReference]?) -> [NodeReference]? {
         var nodeReferences = [NodeReference]()
      
        if let waysData = wayData {
             let tempNodeReferences = waysData.way?.map{ $0.nodeReference }
            for node in tempNodeReferences ?? [] {
                if let _ = node {
                    nodeReferences.append(contentsOf: node!)
                }
            }
        } else {
            nodeReferences = nodeReference!
        }
       
       
        let nonNilNodeData = nodeReferences.filter({ (objNode) -> Bool in
            if let attributes = objNode.attributes {
                let kerbHeight = attributes.filter {$0.key == "kerb:height"}
                if kerbHeight.count>0{
                    return true
                }
            }
            
            return false
            
        })
        var uniquesNodes = [NodeReference]()
        for node in nonNilNodeData
        {
            let duplicateNodes = uniquesNodes.filter({ (objNode) -> Bool in
                return objNode.apiWayId == node.apiWayId
            })
            if duplicateNodes.count == 0
            {
                uniquesNodes.append(node)
            }
        }
       return uniquesNodes
    }
    
    func showLoader() {
//        let vC = UIApplication.shared.visibleViewController as! BaseViewController
//       vC.showLoader(vC)
    }
    
    func hideLoader() {
//        let vC = UIApplication.shared.visibleViewController as! BaseViewController
       // vC.hideLoader(vC)
    }
    
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {
        
    }
}
