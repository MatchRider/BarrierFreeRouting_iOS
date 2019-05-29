//
//  Segments.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Segments: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let steps = "steps"
    static let distance = "distance"
    static let duration = "duration"
    static let ascent = "ascent"
    static let descent = "descent"
  }

  // MARK: Properties
  public var steps: [Steps]?
  public var distance: Float?
  public var duration: Float?
  public var ascent: Float?
  public var descent: Float?

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
    steps <- map[SerializationKeys.steps]
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
    if let value = steps { dictionary[SerializationKeys.steps] = value.map { $0.dictionaryRepresentation() } }
    if let value = distance { dictionary[SerializationKeys.distance] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value }
    if let value = ascent { dictionary[SerializationKeys.ascent] = value }
    if let value = descent { dictionary[SerializationKeys.descent] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.steps = aDecoder.decodeObject(forKey: SerializationKeys.steps) as? [Steps]
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? Float
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? Float
    self.ascent = aDecoder.decodeObject(forKey: SerializationKeys.ascent) as? Float
    self.descent = aDecoder.decodeObject(forKey: SerializationKeys.descent) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(steps, forKey: SerializationKeys.steps)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
    aCoder.encode(ascent, forKey: SerializationKeys.ascent)
    aCoder.encode(descent, forKey: SerializationKeys.descent)
  }

}
