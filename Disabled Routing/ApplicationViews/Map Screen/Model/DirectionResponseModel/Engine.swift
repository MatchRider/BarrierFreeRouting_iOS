//
//  Engine.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Engine: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let version = "version"
    static let buildDate = "build_date"
  }

  // MARK: Properties
  public var version: String?
  public var buildDate: String?

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
    version <- map[SerializationKeys.version]
    buildDate <- map[SerializationKeys.buildDate]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = version { dictionary[SerializationKeys.version] = value }
    if let value = buildDate { dictionary[SerializationKeys.buildDate] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.version = aDecoder.decodeObject(forKey: SerializationKeys.version) as? String
    self.buildDate = aDecoder.decodeObject(forKey: SerializationKeys.buildDate) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(version, forKey: SerializationKeys.version)
    aCoder.encode(buildDate, forKey: SerializationKeys.buildDate)
  }

}
