//
//  Steps.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Steps: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let instruction = "instruction"
    static let name = "name"
    static let exitNumber = "exit_number"
    static let distance = "distance"
    static let wayPoints = "way_points"
    static let type = "type"
    static let duration = "duration"
  }

  // MARK: Properties
  public var instruction: String?
  public var name: String?
  public var exitNumber: Int?
  public var distance: Double?
  public var wayPoints: [Int]?
  public var type: Int?
  public var duration: Int?

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
    instruction <- map[SerializationKeys.instruction]
    name <- map[SerializationKeys.name]
    exitNumber <- map[SerializationKeys.exitNumber]
    distance <- map[SerializationKeys.distance]
    wayPoints <- map[SerializationKeys.wayPoints]
    type <- map[SerializationKeys.type]
    duration <- map[SerializationKeys.duration]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = instruction { dictionary[SerializationKeys.instruction] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = exitNumber { dictionary[SerializationKeys.exitNumber] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value }
    if let value = wayPoints { dictionary[SerializationKeys.wayPoints] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.instruction = aDecoder.decodeObject(forKey: SerializationKeys.instruction) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.exitNumber = aDecoder.decodeObject(forKey: SerializationKeys.exitNumber) as? Int
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? Double
    self.wayPoints = aDecoder.decodeObject(forKey: SerializationKeys.wayPoints) as? [Int]
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? Int
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(instruction, forKey: SerializationKeys.instruction)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(exitNumber, forKey: SerializationKeys.exitNumber)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(wayPoints, forKey: SerializationKeys.wayPoints)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
  }

}
