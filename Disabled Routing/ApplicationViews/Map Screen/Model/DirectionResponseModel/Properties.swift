//
//  Properties.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Properties: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let segments = "segments"
    static let bbox = "bbox"
    static let wayPoints = "way_points"
    static let summary = "summary"
  }

  // MARK: Properties
  public var segments: [Segments]?
  public var bbox: [Float]?
  public var wayPoints: [Int]?
  public var summary: [Summary]?

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
    segments <- map[SerializationKeys.segments]
    bbox <- map[SerializationKeys.bbox]
    wayPoints <- map[SerializationKeys.wayPoints]
    summary <- map[SerializationKeys.summary]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = segments { dictionary[SerializationKeys.segments] = value.map { $0.dictionaryRepresentation() } }
    if let value = bbox { dictionary[SerializationKeys.bbox] = value }
    if let value = wayPoints { dictionary[SerializationKeys.wayPoints] = value }
    if let value = summary { dictionary[SerializationKeys.summary] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.segments = aDecoder.decodeObject(forKey: SerializationKeys.segments) as? [Segments]
    self.bbox = aDecoder.decodeObject(forKey: SerializationKeys.bbox) as? [Float]
    self.wayPoints = aDecoder.decodeObject(forKey: SerializationKeys.wayPoints) as? [Int]
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? [Summary]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(segments, forKey: SerializationKeys.segments)
    aCoder.encode(bbox, forKey: SerializationKeys.bbox)
    aCoder.encode(wayPoints, forKey: SerializationKeys.wayPoints)
    aCoder.encode(summary, forKey: SerializationKeys.summary)
  }

}
