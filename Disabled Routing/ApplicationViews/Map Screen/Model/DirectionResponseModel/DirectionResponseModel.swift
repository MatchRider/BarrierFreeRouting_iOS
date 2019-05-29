//
//  DirectionResponseModel.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class DirectionResponseModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let features = "features"
    static let info = "info"
    static let bbox = "bbox"
    static let type = "type"
    static let error = "error"
  }

  // MARK: Properties
  public var features: [Features]?
  public var info: Info?
  public var bbox: [Float]?
  public var type: String?
  public var error: DirectionError?

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
    error <- map[SerializationKeys.error]
    info <- map[SerializationKeys.info]
    bbox <- map[SerializationKeys.bbox]
    type <- map[SerializationKeys.type]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = features { dictionary[SerializationKeys.features] = value.map { $0.dictionaryRepresentation() } }
    if let value = error { dictionary[SerializationKeys.error] = value.dictionaryRepresentation() }
    if let value = info { dictionary[SerializationKeys.info] = value.dictionaryRepresentation() }
    if let value = bbox { dictionary[SerializationKeys.bbox] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.features = aDecoder.decodeObject(forKey: SerializationKeys.features) as? [Features]
    self.info = aDecoder.decodeObject(forKey: SerializationKeys.info) as? Info
    self.bbox = aDecoder.decodeObject(forKey: SerializationKeys.bbox) as? [Float]
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
     self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? DirectionError
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(features, forKey: SerializationKeys.features)
    aCoder.encode(info, forKey: SerializationKeys.info)
    aCoder.encode(bbox, forKey: SerializationKeys.bbox)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(error, forKey: SerializationKeys.error)
  }

}
