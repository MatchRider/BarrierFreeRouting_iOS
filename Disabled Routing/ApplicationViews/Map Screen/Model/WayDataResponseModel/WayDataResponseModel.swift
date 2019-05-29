//
//  WayDataResponseModel.swift
//
//  Created by Daffodil_pc on 03/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class WayDataResponseModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let waysData = "WayData"
    static let status = "Status"
    static let error = "Error"
  }

  // MARK: Properties
  public var waysData: [WaysData]?
  public var status: Bool? = false

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
    waysData <- map[SerializationKeys.waysData]
    status <- map[SerializationKeys.status]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = waysData { dictionary[SerializationKeys.waysData] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.status] = status
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.waysData = aDecoder.decodeObject(forKey: SerializationKeys.waysData) as? [WaysData]
    self.status = aDecoder.decodeBool(forKey: SerializationKeys.status)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(waysData, forKey: SerializationKeys.waysData)
    aCoder.encode(status, forKey: SerializationKeys.status)
  }

}
