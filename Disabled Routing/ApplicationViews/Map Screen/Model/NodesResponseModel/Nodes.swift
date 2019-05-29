//
//  Nodes.swift
//
//  Created by  on 29/03/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Nodes: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let wheelchair = "wheelchair"
    static let name = "name"
    static let nodeType = "node_type"
    static let lat = "lat"
    static let category = "category"
    static let wheelchairToilet = "wheelchair_toilet"
    static let id = "id"
    static let lon = "lon"
  }

  // MARK: Properties
  public var wheelchair: String?
  public var name: String?
  public var nodeType: NodeType?
  public var lat: Float?
  public var category: Category?
  public var wheelchairToilet: String?
  public var id: Int?
  public var lon: Float?

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
    wheelchair <- map[SerializationKeys.wheelchair]
    name <- map[SerializationKeys.name]
    nodeType <- map[SerializationKeys.nodeType]
    lat <- map[SerializationKeys.lat]
    category <- map[SerializationKeys.category]
    wheelchairToilet <- map[SerializationKeys.wheelchairToilet]
    id <- map[SerializationKeys.id]
    lon <- map[SerializationKeys.lon]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = wheelchair { dictionary[SerializationKeys.wheelchair] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = nodeType { dictionary[SerializationKeys.nodeType] = value.dictionaryRepresentation() }
    if let value = lat { dictionary[SerializationKeys.lat] = value }
    if let value = category { dictionary[SerializationKeys.category] = value.dictionaryRepresentation() }
    if let value = wheelchairToilet { dictionary[SerializationKeys.wheelchairToilet] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = lon { dictionary[SerializationKeys.lon] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.wheelchair = aDecoder.decodeObject(forKey: SerializationKeys.wheelchair) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.nodeType = aDecoder.decodeObject(forKey: SerializationKeys.nodeType) as? NodeType
    self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? Float
    self.category = aDecoder.decodeObject(forKey: SerializationKeys.category) as? Category
    self.wheelchairToilet = aDecoder.decodeObject(forKey: SerializationKeys.wheelchairToilet) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.lon = aDecoder.decodeObject(forKey: SerializationKeys.lon) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(wheelchair, forKey: SerializationKeys.wheelchair)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(nodeType, forKey: SerializationKeys.nodeType)
    aCoder.encode(lat, forKey: SerializationKeys.lat)
    aCoder.encode(category, forKey: SerializationKeys.category)
    aCoder.encode(wheelchairToilet, forKey: SerializationKeys.wheelchairToilet)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(lon, forKey: SerializationKeys.lon)
  }

}
