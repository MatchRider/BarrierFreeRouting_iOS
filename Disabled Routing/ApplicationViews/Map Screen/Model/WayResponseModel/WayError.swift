//
//  Error.swift
//
//  Created by Hürdenlose Navigation on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WayError: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let code = "Code"
    static let isError = "IsError"
    static let message = "Message"
  }

  // MARK: Properties
  public var code: String?
  public var isError: Bool? = false
  public var message: String?

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
    code <- map[SerializationKeys.code]
    isError <- map[SerializationKeys.isError]
    message <- map[SerializationKeys.message]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = code { dictionary[SerializationKeys.code] = value }
    dictionary[SerializationKeys.isError] = isError
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? String
    self.isError = aDecoder.decodeBool(forKey: SerializationKeys.isError)
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(isError, forKey: SerializationKeys.isError)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
