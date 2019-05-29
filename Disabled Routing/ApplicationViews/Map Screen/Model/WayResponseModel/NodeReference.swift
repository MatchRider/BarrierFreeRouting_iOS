//
//  NodeReference.swift
//
//  Created by Daffodil_pc on 18/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class NodeReference: Mappable, NSCoding,NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = NodeReference(JSON: [:])!
        copy.apiWayId = self.apiWayId
        copy.osmNodeId = self.osmNodeId
        copy.lat = self.lat
        copy.attributes = []
        for attribute in self.attributes ?? [] {
          
            copy.attributes?.append(attribute.copy() as! Attributes)
        }
        copy.version = self.version
        copy.lon = self.lon
        return copy
    }
    public func updateModel(withData copy:NodeReference) {
        self.apiWayId = copy.apiWayId
        self.osmNodeId = copy.osmNodeId
        self.lat = copy.lat
        for (index,attribute) in copy.attributes?.enumerated() ?? [].enumerated() {
            self.attributes![index].updateModel(withData: attribute)
        }
        self.version = copy.version
        self.lon = copy.lon
    }
     init(withOSMNode node:OSMElement) {
        self.apiWayId = node._id
        self.osmNodeId = node._id
        self.lat = node._lat
        self.attributes = []
        for tag in node.tag ?? [] {
            let attribute = Attributes(withOSMAttributes: tag)
            self.attributes?.append(attribute)
        }
        self.version = node._version
        self.lon = node._lon
    }
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let lat = "Lat"
        static let version = "Version"
        static let attributes = "Attributes"
        static let osmNodeId = "OSMNodeId"
        static let apiNodeId = "APINodeId"
        static let lon = "Lon"
    }
    
    // MARK: Properties
    public var lat: String?
    public var version: String?
    public var attributes: [Attributes]?
    public var lon: String?
    public var osmNodeId: String?
    public var apiWayId: String?
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
        lat <- map[SerializationKeys.lat]
        version <- map[SerializationKeys.version]
        attributes <- map[SerializationKeys.attributes]
        osmNodeId <- map[SerializationKeys.osmNodeId]
        apiWayId <- map[SerializationKeys.apiNodeId]
        lon <- map[SerializationKeys.lon]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = lat { dictionary[SerializationKeys.lat] = value }
        if let value = version { dictionary[SerializationKeys.version] = value }
        if let value = attributes { dictionary[SerializationKeys.attributes] = value.map { $0.dictionaryRepresentation() } }
        if let value = osmNodeId { dictionary[SerializationKeys.osmNodeId] = value }
        if let value = apiWayId { dictionary[SerializationKeys.apiNodeId] = value }
        if let value = lon { dictionary[SerializationKeys.lon] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? String
        self.version = aDecoder.decodeObject(forKey: SerializationKeys.version) as? String
        self.attributes = aDecoder.decodeObject(forKey: SerializationKeys.attributes) as? [Attributes]
        self.osmNodeId = aDecoder.decodeObject(forKey: SerializationKeys.osmNodeId) as? String
         self.apiWayId = aDecoder.decodeObject(forKey: SerializationKeys.apiNodeId) as? String
        self.lon = aDecoder.decodeObject(forKey: SerializationKeys.lon) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: SerializationKeys.lat)
        aCoder.encode(version, forKey: SerializationKeys.version)
        aCoder.encode(attributes, forKey: SerializationKeys.attributes)
        aCoder.encode(osmNodeId, forKey: SerializationKeys.osmNodeId)
        aCoder.encode(apiWayId, forKey: SerializationKeys.apiNodeId)
        aCoder.encode(lon, forKey: SerializationKeys.lon)
    }
}

