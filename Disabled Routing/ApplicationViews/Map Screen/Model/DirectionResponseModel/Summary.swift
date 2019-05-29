//
//  Summary.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Summary: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let distance = "distance"
    static let duration = "duration"
    static let ascent = "ascent"
    static let descent = "descent"
  }

  // MARK: Properties
  public var distance: Double?
  public var duration: Int?
  public var ascent: Double?
  public var descent: Double?

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
    distance <- map[SerializationKeys.distance]
    duration <- map[SerializationKeys.duration]
    ascent <- map[SerializationKeys.ascent]
    descent <- map[SerializationKeys.descent]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = distance { dictionary[SerializationKeys.distance] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value }
    if let value = ascent { dictionary[SerializationKeys.ascent] = value }
    if let value = descent { dictionary[SerializationKeys.descent] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? Double
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? Int
    self.ascent = aDecoder.decodeObject(forKey: SerializationKeys.ascent) as? Double
    self.descent = aDecoder.decodeObject(forKey: SerializationKeys.descent) as? Double
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
    aCoder.encode(ascent, forKey: SerializationKeys.ascent)
    aCoder.encode(descent, forKey: SerializationKeys.descent)
  }

}
