//
//  Attributes.swift
//
//  Created by Hürdenlose Navigation on 30/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Attributes: Mappable, NSCoding,NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
         let copy = Attributes(JSON: [:])!
        copy.value = self.value
        copy.key = self.key
        copy.isValid = self.isValid
        
        return copy
    }
     public func updateModel(withData copy:Attributes) {
        self.value = copy.value
        self.key = copy.key
        self.isValid = copy.isValid
    }

    init(withOSMAttributes tag:Tag) {
        self.value = tag._v
        self.key = tag._k
        self.isValid = "false"
    }
  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let value = "Value"
    static let key = "Key"
    static let isValid = "IsValid"
  }

  // MARK: Properties
  public var value: String?
  public var key: String?
  public var isValid: String?

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
    value <- map[SerializationKeys.value]
    key <- map[SerializationKeys.key]
    isValid <- map[SerializationKeys.isValid]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = value { dictionary[SerializationKeys.value] = value }
    if let value = key { dictionary[SerializationKeys.key] = value }
    if let value = isValid { dictionary[SerializationKeys.isValid] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? String
    self.key = aDecoder.decodeObject(forKey: SerializationKeys.key) as? String
    self.isValid = aDecoder.decodeObject(forKey: SerializationKeys.isValid) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(value, forKey: SerializationKeys.value)
    aCoder.encode(key, forKey: SerializationKeys.key)
    aCoder.encode(isValid, forKey: SerializationKeys.isValid)
  }

}
