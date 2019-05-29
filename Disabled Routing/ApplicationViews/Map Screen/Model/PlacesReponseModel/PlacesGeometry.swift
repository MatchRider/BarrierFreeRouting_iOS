//
//  PlacesGeometry.swift
//
//  Created by Hürdenlose Navigation on 11/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PlacesGeometry: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let type = "type"
    static let coordinates = "coordinates"
  }

  // MARK: Properties
  public var type: String?
  public var coordinates: [Double]?

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
    type <- map[SerializationKeys.type]
    coordinates <- map[SerializationKeys.coordinates]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = coordinates { dictionary[SerializationKeys.coordinates] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.coordinates = aDecoder.decodeObject(forKey: SerializationKeys.coordinates) as? [Double]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(coordinates, forKey: SerializationKeys.coordinates)
  }

}
