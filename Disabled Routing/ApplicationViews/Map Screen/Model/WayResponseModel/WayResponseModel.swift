//
//  WayResponseModel.swift
//
//  Created by Hürdenlose Navigation on 30/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WayResponseModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "Status"
        static let error = "Error"
    static let wayData = "WayData"
  }

  // MARK: Properties
  public var status: Bool? = false
  public var way: [WayData]?
      public var error: [WayError]?

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
    status <- map[SerializationKeys.status]
    way <- map[SerializationKeys.wayData]
     error <- map[SerializationKeys.error]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.status] = status
    if let value = way { dictionary[SerializationKeys.wayData] = value.map { $0.dictionaryRepresentation() } }
     if let value = error { dictionary[SerializationKeys.error] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeBool(forKey: SerializationKeys.status)
    self.way = aDecoder.decodeObject(forKey: SerializationKeys.wayData) as? [WayData]
    self.error = aDecoder.decodeObject(forKey: SerializationKeys.error) as? [Error] as! [WayError]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(way, forKey: SerializationKeys.wayData)
    aCoder.encode(error, forKey: SerializationKeys.error)
  }

}
