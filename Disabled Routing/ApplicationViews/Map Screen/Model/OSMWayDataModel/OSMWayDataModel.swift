//
//  OSMWayDataModel.swift
//  Disabled Routing
//
//  Created by Daffodil_pc on 26/07/18.
//  Copyright © 2018 Daffodil_pc. All rights reserved.
//

import AlamofireXmlToObjects
import EVReflection
class OSMWayDataModel: EVObject {
    var osm: String?
}
class OSM: EVObject {
    var way: [Way]?
    var node: [Node]?
}
class Way: EVObject {
    public var nd: [Nd]?
    public var _id: String?
    public var tag: [Tag]?
}
class Node: EVObject {
    public var _lon: String?
    public var _id: String?
    public var _lat: String?
    public var tag: Tag?
}
class Tag: EVObject {
    public var _v: String?
    public var _k: String?
}
class Nd: EVObject {
     public var _ref: String?
}

class WayData
{
    public var node: [Node]?
    public var id: String?
    public var tag: [Tag]?
    public var latlongs = [[Double]]()
}

