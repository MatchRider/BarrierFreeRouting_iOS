//
//  ErrorResponse.swift
//
//  Created by  on 26/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class ErrorResponse: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let info = "info"
    static let error = "error"
  }

  // MARK: Properties
  public var info: Info?
  public var error: ServiceError?

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
    info <- map[SerializationKeys.info]
    error <- map[SerializationKeys.error]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = info { dictionary[SerializationKeys.info] = value.dictionaryRepresentation() }
    if let value = error { dictionary[SerializationKeys.error] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.info = aDecoder.decodeObject(forKey: SerializationKeys.info) as? Info
    self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? ServiceError
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(info, forKey: SerializationKeys.info)
    aCoder.encode(error, forKey: SerializationKeys.error)
  }

}
