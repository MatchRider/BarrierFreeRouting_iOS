//
//  PlacesGeocoding.swift
//
//  Created by Hürdenlose Navigation on 11/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PlacesGeocoding: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let errors = "errors"
  }

  // MARK: Properties
  public var errors: [String]?

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
    errors <- map[SerializationKeys.errors]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = errors { dictionary[SerializationKeys.errors] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.errors = aDecoder.decodeObject(forKey: SerializationKeys.errors) as? [String]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(errors, forKey: SerializationKeys.errors)
  }

}
