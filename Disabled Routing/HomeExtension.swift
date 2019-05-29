//
//  HomeExtension.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 26/07/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import AEXML
import AlamofireXmlToObjects
import EVReflection
extension MapView
{
//        private func getFileData() -> OSM?
//        {
//            guard let xmlPath = Bundle.main.path(forResource: "Heidelberg_Dev_Data", ofType: "osm"),
//                let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
//                else { return nil }
//           let objOSM = OSM(xmlData: data)
//            return objOSM
//        }
//        func getWayDataInfo(completionHandler:(([WayData],[WayData],[WayData])->Void)?)
//        {
//            
//            if self.wayOSMData.count != 0
//            {
//                 DispatchQueue.main.async { completionHandler?(self.wayOSMData,self.inValidatedOSMData,self.validatedWayOSMData)
//                    return
//                }
//            }
//            else {
//            DispatchQueue.global(qos: .userInitiated).async {
//                let osmData = self.getFileData()
//                self.wayOSMData = self.getCustomWayData(fromOSMData:osmData!)
//                for index in self.wayOSMData.indices
//                {
//                    if index % 2 == 0
//                    {
//                        self.inValidatedOSMData.append(self.wayOSMData[index])
//                    }
//                    else
//                    {
//                        self.validatedWayOSMData.append(self.wayOSMData[index])
//                    }
//                }
//                DispatchQueue.main.async {
//                     completionHandler?(self.wayOSMData,self.inValidatedOSMData,self.validatedWayOSMData)
//                }
//            }
//            }
//        }
//        private func getCustomWayData(fromOSMData osmData:OSM)->[WayData]?
//        {
//            var mappedNodes = [String:Node]()
//            mappedNodes = (osmData.node?.reduce([String:Node](), { (dictionary, obj) -> [String:Node] in
//                var temp = dictionary
//                temp[obj._id!] = obj
//                return temp
//            }))!
//            
//            var objWayData = [WayData]()
//            for obj in osmData.way!
//            {
//                var objNodes = [Node]()
//                
//                let objWay = WayData()
//                
//                objWay.id = obj._id
//                objWay.tag = obj.tag
//                
//                for objNd in obj.nd!{
//                    objNodes.append(mappedNodes[objNd._ref!]!)
//                }
//                objWay.node = objNodes
//                objWay.latlongs = (objWay.node?.map{
//                    let lat = Double($0._lat!) ?? 0.0
//                    let long = Double($0._lon!) ?? 0.0
//                    return [lat,long]
//                    })!
//                objWayData.append(objWay)
//            }
//            return objWayData
//        }
    
}
