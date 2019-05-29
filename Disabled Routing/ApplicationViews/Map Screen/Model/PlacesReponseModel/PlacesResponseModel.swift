//
//  PlacesResponseModel.swift
//
//  Created by Hürdenlose Navigation on 11/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PlacesResponseModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let features = "features"
    static let bbox = "bbox"
    static let geocoding = "geocoding"
    static let type = "type"
  }

  // MARK: Properties
  public var features: [PlacesFeatures]?
  public var bbox: [Float]?
  public var geocoding: PlacesGeocoding?
  public var type: String?

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
    features <- map[SerializationKeys.features]
    bbox <- map[SerializationKeys.bbox]
    geocoding <- map[SerializationKeys.geocoding]
    type <- map[SerializationKeys.type]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = features { dictionary[SerializationKeys.features] = value.map { $0.dictionaryRepresentation() } }
    if let value = bbox { dictionary[SerializationKeys.bbox] = value }
    if let value = geocoding { dictionary[SerializationKeys.geocoding] = value.dictionaryRepresentation() }
    if let value = type { dictionary[SerializationKeys.type] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.features = aDecoder.decodeObject(forKey: SerializationKeys.features) as? [PlacesFeatures]
    self.bbox = aDecoder.decodeObject(forKey: SerializationKeys.bbox) as? [Float]
    self.geocoding = aDecoder.decodeObject(forKey: SerializationKeys.geocoding) as? PlacesGeocoding
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(features, forKey: SerializationKeys.features)
    aCoder.encode(bbox, forKey: SerializationKeys.bbox)
    aCoder.encode(geocoding, forKey: SerializationKeys.geocoding)
    aCoder.encode(type, forKey: SerializationKeys.type)
  }

}
