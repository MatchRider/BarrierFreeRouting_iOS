//
//  WaysData.swift
//
//  Created by Daffodil_pc on 03/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WaysData: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let attributes = "Attributes"
    static let id = "Id"
  }

  // MARK: Properties
  public var attributes: [Attributes]?
  public var id: String?

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
    attributes <- map[SerializationKeys.attributes]
    id <- map[SerializationKeys.id]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = attributes { dictionary[SerializationKeys.attributes] = value.map { $0.dictionaryRepresentation() } }
    if let value = id { dictionary[SerializationKeys.id] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.attributes = aDecoder.decodeObject(forKey: SerializationKeys.attributes) as? [Attributes]
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(attributes, forKey: SerializationKeys.attributes)
    aCoder.encode(id, forKey: SerializationKeys.id)
  }

}
