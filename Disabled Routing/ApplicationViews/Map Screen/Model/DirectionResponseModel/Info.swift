//
//  Info.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Info: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let service = "service"
    static let query = "query"
    static let engine = "engine"
    static let attribution = "attribution"
    static let osmFileMd5Hash = "osm_file_md5_hash"
    static let timestamp = "timestamp"
  }

  // MARK: Properties
  public var service: String?
  public var query: Query?
  public var engine: Engine?
  public var attribution: String?
  public var osmFileMd5Hash: String?
  public var timestamp: Int?

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
    service <- map[SerializationKeys.service]
    query <- map[SerializationKeys.query]
    engine <- map[SerializationKeys.engine]
    attribution <- map[SerializationKeys.attribution]
    osmFileMd5Hash <- map[SerializationKeys.osmFileMd5Hash]
    timestamp <- map[SerializationKeys.timestamp]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = service { dictionary[SerializationKeys.service] = value }
    if let value = query { dictionary[SerializationKeys.query] = value.dictionaryRepresentation() }
    if let value = engine { dictionary[SerializationKeys.engine] = value.dictionaryRepresentation() }
    if let value = attribution { dictionary[SerializationKeys.attribution] = value }
    if let value = osmFileMd5Hash { dictionary[SerializationKeys.osmFileMd5Hash] = value }
    if let value = timestamp { dictionary[SerializationKeys.timestamp] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.service = aDecoder.decodeObject(forKey: SerializationKeys.service) as? String
    self.query = aDecoder.decodeObject(forKey: SerializationKeys.query) as? Query
    self.engine = aDecoder.decodeObject(forKey: SerializationKeys.engine) as? Engine
    self.attribution = aDecoder.decodeObject(forKey: SerializationKeys.attribution) as? String
    self.osmFileMd5Hash = aDecoder.decodeObject(forKey: SerializationKeys.osmFileMd5Hash) as? String
    self.timestamp = aDecoder.decodeObject(forKey: SerializationKeys.timestamp) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(service, forKey: SerializationKeys.service)
    aCoder.encode(query, forKey: SerializationKeys.query)
    aCoder.encode(engine, forKey: SerializationKeys.engine)
    aCoder.encode(attribution, forKey: SerializationKeys.attribution)
    aCoder.encode(osmFileMd5Hash, forKey: SerializationKeys.osmFileMd5Hash)
    aCoder.encode(timestamp, forKey: SerializationKeys.timestamp)
  }

}
