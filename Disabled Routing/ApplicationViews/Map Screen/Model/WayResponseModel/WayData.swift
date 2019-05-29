//
//  WayData.swift
//
//  Created by Hürdenlose Navigation on 30/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WayData: Mappable, NSCoding,NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = WayData(JSON: [:])!
        copy.isValid = self.isValid
        copy.version = self.version
        copy.coordinatesData = self.coordinatesData
        copy.coordinatesDouble = self.coordinatesDouble
         copy.attributes = [Attributes]()
        for attribute in self.attributes ?? [] {
            copy.attributes!.append(attribute.copy() as! Attributes)
        }
        
        copy.nodeReference = [NodeReference]()
        for nodeRef in self.nodeReference ?? [] {
            copy.nodeReference!.append(nodeRef.copy() as! NodeReference)
        }
        copy.nodeReference = self.nodeReference
        copy.color = self.color
        copy.projectId = self.projectId
        copy.apiWayId = self.apiWayId
        copy.osmWayId = self.osmWayId
        copy.isWaySideWalk = self.isWaySideWalk
        copy.isWayContainSideWalk = self.isWayContainSideWalk
        copy.isOSMWay = self.isOSMWay
        return copy
    }
    public func updateModel(withData copy:WayData) {
        self.isValid = copy.isValid
        self.version = copy.version
        self.coordinatesData = copy.coordinatesData
        self.coordinatesDouble = copy.coordinatesDouble

        for (index,attribute) in copy.attributes?.enumerated() ?? [].enumerated() {
            self.attributes![index].updateModel(withData: attribute)
        }
        
        for (index,noderef) in copy.nodeReference?.enumerated() ?? [].enumerated() {
            self.nodeReference![index].updateModel(withData: noderef)
        }
        self.nodeReference = copy.nodeReference
        self.color = copy.color
        self.projectId = copy.projectId
        self.apiWayId = copy.apiWayId
        self.osmWayId = copy.osmWayId
        self.isWaySideWalk = copy.isWaySideWalk
        self.isWayContainSideWalk = copy.isWayContainSideWalk
        self.isOSMWay = copy.isOSMWay
    }

  // MARK: Declaration for string constants to be used to decode and also serialize.
    
    init(withOSMWay way:OSMElement,andAllNode nodes :[NodeReference]) {
        //For sidewalk as seperate way
        var isHighwayEqualsFootway = false
        var isFootwayEqualsSidewalk = false
        
        //For Sidewalk part of highway
        var isHighwayEqualsSecondary = false
        var doContainSidewalk = false
        /*
         footway = sidewalk
         highway = footway
         
         
         */
        self.apiWayId = way._id
        self.osmWayId = way._id
        var attributes : [Attributes] = []
        for tag in way.tag ?? [] {
            let attribute = Attributes(withOSMAttributes: tag)
            if attribute.key == "footway" && attribute.value == "sidewalk" {
                isFootwayEqualsSidewalk = true
            }
            
            if attribute.key == "highway" && attribute.value == "footway" {
                isHighwayEqualsFootway = true
            }
            
            if attribute.key == "sidewalk" {
                doContainSidewalk = true
            }
//            if attribute.key == "highway" && attribute.value == "secondary" {
//                isHighwayEqualsSecondary = true
//            }
            attributes.append(attribute)
        }
        self.version = way._version
        self.isValid = "false"
        self.attributes = attributes
        self.isOSMWay = true
        var nodeIds = [String]()
        for nodeRef in way.nd ?? [] {
            if let  refID = nodeRef._ref {
                nodeIds.append(refID)
            }
        }
        self.nodeReference = nodes.filter({ (objNode) -> Bool in
            nodeIds.contains(objNode.osmNodeId!)
        })
        self.coordinatesData = self.nodeReference?.map({ (obj) -> [String] in
            return [obj.lat!,obj.lon!]
        })
        self.color = UIColor.randomHexColorCode()
        self.projectId = "1"
        
        if (isHighwayEqualsFootway && isFootwayEqualsSidewalk) {
            self.isWaySideWalk = true
        }
        if (doContainSidewalk) {
             self.isWayContainSideWalk = true
        }
    }
  private struct SerializationKeys {
    static let isValid = "IsValid"
    static let coordinates = "Coordinates"
    static let attributes = "Attributes"
    static let color = "Color"
    static let version = "Version"
    static let nodeReference = "NodeReference"
    static let projectId = "ProjectId"
    static let osmWayId = "OSMWayId"
    static let apiWayId = "APIWayId"
    
  }

  // MARK: Properties
    public var isValid : String?
    public var version : String?
    public var coordinatesData: [[String]]?
    public var coordinatesDouble: [[Double]]?
    public var attributes: [Attributes]?
    public var nodeReference: [NodeReference]?
    public var color: String?
    public var projectId: String?
    public var apiWayId: String?
    public var osmWayId: String?
    public var isWaySideWalk = false
    public var isWayContainSideWalk = false
    public var isOSMWay = false

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    isValid <- map[SerializationKeys.isValid]
    version <- map[SerializationKeys.version]
    coordinatesData <- map[SerializationKeys.coordinates]
    attributes <- map[SerializationKeys.attributes]
    color <- map[SerializationKeys.color]
    projectId <- map[SerializationKeys.projectId]
    osmWayId <- map[SerializationKeys.osmWayId]
    apiWayId <- map[SerializationKeys.apiWayId]
    nodeReference <- map[SerializationKeys.nodeReference]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isValid { dictionary[SerializationKeys.isValid] = value }
    if let value = coordinatesData { dictionary[SerializationKeys.coordinates] = value.map { $0 } }
    if let value = nodeReference { dictionary[SerializationKeys.nodeReference] = value.map { $0 } }
    if let value = attributes { dictionary[SerializationKeys.attributes] = value.map { $0.dictionaryRepresentation() } }
    if let value = color { dictionary[SerializationKeys.color] = value }
    if let value = projectId { dictionary[SerializationKeys.projectId] = value }
    if let value = version { dictionary[SerializationKeys.version] = value }
    if let value = osmWayId { dictionary[SerializationKeys.osmWayId] = value }
    if let value = apiWayId { dictionary[SerializationKeys.apiWayId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isValid = aDecoder.decodeObject(forKey: SerializationKeys.isValid) as? String
    self.coordinatesData = aDecoder.decodeObject(forKey: SerializationKeys.coordinates) as? [[String]]
    self.attributes = aDecoder.decodeObject(forKey: SerializationKeys.attributes) as? [Attributes]
    self.nodeReference = aDecoder.decodeObject(forKey: SerializationKeys.nodeReference) as? [NodeReference]
    self.color = aDecoder.decodeObject(forKey: SerializationKeys.color) as? String
    self.projectId = aDecoder.decodeObject(forKey: SerializationKeys.projectId) as? String
    self.version = aDecoder.decodeObject(forKey: SerializationKeys.version) as? String
    self.osmWayId = aDecoder.decodeObject(forKey: SerializationKeys.osmWayId) as? String
    self.apiWayId = aDecoder.decodeObject(forKey: SerializationKeys.apiWayId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isValid, forKey: SerializationKeys.isValid)
    aCoder.encode(version, forKey: SerializationKeys.version)
    aCoder.encode(coordinatesData, forKey: SerializationKeys.coordinates)
    aCoder.encode(attributes, forKey: SerializationKeys.attributes)
    aCoder.encode(color, forKey: SerializationKeys.color)
    aCoder.encode(nodeReference, forKey: SerializationKeys.nodeReference)
    aCoder.encode(projectId, forKey: SerializationKeys.projectId)
    aCoder.encode(osmWayId, forKey: SerializationKeys.osmWayId)
     aCoder.encode(apiWayId, forKey: SerializationKeys.apiWayId)
  }

}
