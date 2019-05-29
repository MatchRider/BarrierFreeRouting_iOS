//
//  PlacesFeatures.swift
//
//  Created by Hürdenlose Navigation on 11/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PlacesFeatures: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let geometry = "geometry"
    static let bbox = "bbox"
    static let type = "type"
    static let properties = "properties"
  }

  // MARK: Properties
  public var geometry: PlacesGeometry?
  public var bbox: [Float]?
  public var type: String?
  public var properties: PlacesProperties?

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
    geometry <- map[SerializationKeys.geometry]
    bbox <- map[SerializationKeys.bbox]
    type <- map[SerializationKeys.type]
    properties <- map[SerializationKeys.properties]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = geometry { dictionary[SerializationKeys.geometry] = value.dictionaryRepresentation() }
    if let value = bbox { dictionary[SerializationKeys.bbox] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = properties { dictionary[SerializationKeys.properties] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.geometry = aDecoder.decodeObject(forKey: SerializationKeys.geometry) as? PlacesGeometry
    self.bbox = aDecoder.decodeObject(forKey: SerializationKeys.bbox) as? [Float]
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.properties = aDecoder.decodeObject(forKey: SerializationKeys.properties) as? PlacesProperties
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(geometry, forKey: SerializationKeys.geometry)
    aCoder.encode(bbox, forKey: SerializationKeys.bbox)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(properties, forKey: SerializationKeys.properties)
  }

}
