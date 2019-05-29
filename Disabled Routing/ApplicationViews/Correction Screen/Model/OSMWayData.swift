//
//  OSMWayData.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 06/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import EVReflection
class OSMServer: EVObject {
    public var way: [OSMElement]?
    public var node: [OSMElement]?
    
    func toWayResponseModel() -> (ways:WayResponseModel?,nodes:[NodeReference]) {
        let wayResponseModel = WayResponseModel(JSON: [:])
        var nodes = [NodeReference]()
       var ways = [WayData]()
        for node in self.node ?? [] {
            let nodeObj = NodeReference(withOSMNode: node)
            nodes.append(nodeObj)
        }
        for way in self.way ?? [] {
            let wayObj = WayData(withOSMWay: way, andAllNode: nodes)
            if wayObj.isWayContainSideWalk || wayObj.isWaySideWalk {
                if wayObj.isWayContainSideWalk {
                    print(wayObj.osmWayId)
                }
                 ways.append(wayObj)
            }
           
        }
        wayResponseModel?.way = ways
        
        return (wayResponseModel,nodes)
    }
}
class OSM: EVObject {
    public var way: OSMElement?
    public var node: OSMElement?
}
class OSMElement: EVObject {
    public var nd: [Nd]?
    public var _id: String?
    public var _version: String?
    public var tag: [Tag]?
    public var _changeset: String?
    public var _lat: String?
    public var _lon: String?
    public var _timestamp: String?
    public var _uid: String?
    public var _user: String?
    public var _visible: String?
}
class Tag: EVObject {
    public var _v: String?
    public var _k: String?
}
class Nd: EVObject {
    public var _ref: String?
    
}
