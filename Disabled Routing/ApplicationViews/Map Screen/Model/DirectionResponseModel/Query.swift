//
//  Query.swift
//
//  Created by Hürdenlose Navigation on 06/08/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class Query: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let geometry = "geometry"
    static let instructions = "instructions"
    static let preference = "preference"
    static let elevation = "elevation"
    static let geometrySimplify = "geometry_simplify"
    static let units = "units"
    static let geometryFormat = "geometry_format"
    static let language = "language"
    static let coordinates = "coordinates"
    static let instructionsFormat = "instructions_format"
    static let profile = "profile"
  }

  // MARK: Properties
  public var geometry: Bool? = false
  public var instructions: Bool? = false
  public var preference: String?
  public var elevation: Bool? = false
  public var geometrySimplify: Bool? = false
  public var units: String?
  public var geometryFormat: String?
  public var language: String?
  public var coordinates: [[Double]]?
  public var instructionsFormat: String?
  public var profile: String?

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
    geometry <- map[SerializationKeys.geometry]
    instructions <- map[SerializationKeys.instructions]
    preference <- map[SerializationKeys.preference]
    elevation <- map[SerializationKeys.elevation]
    geometrySimplify <- map[SerializationKeys.geometrySimplify]
    units <- map[SerializationKeys.units]
    geometryFormat <- map[SerializationKeys.geometryFormat]
    language <- map[SerializationKeys.language]
    coordinates <- map[SerializationKeys.coordinates]
    instructionsFormat <- map[SerializationKeys.instructionsFormat]
    profile <- map[SerializationKeys.profile]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.geometry] = geometry
    dictionary[SerializationKeys.instructions] = instructions
    if let value = preference { dictionary[SerializationKeys.preference] = value }
    dictionary[SerializationKeys.elevation] = elevation
    dictionary[SerializationKeys.geometrySimplify] = geometrySimplify
    if let value = units { dictionary[SerializationKeys.units] = value }
    if let value = geometryFormat { dictionary[SerializationKeys.geometryFormat] = value }
    if let value = language { dictionary[SerializationKeys.language] = value }
    if let value = coordinates { dictionary[SerializationKeys.coordinates] = value }
    if let value = instructionsFormat { dictionary[SerializationKeys.instructionsFormat] = value }
    if let value = profile { dictionary[SerializationKeys.profile] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.geometry = aDecoder.decodeBool(forKey: SerializationKeys.geometry)
    self.instructions = aDecoder.decodeBool(forKey: SerializationKeys.instructions)
    self.preference = aDecoder.decodeObject(forKey: SerializationKeys.preference) as? String
    self.elevation = aDecoder.decodeBool(forKey: SerializationKeys.elevation)
    self.geometrySimplify = aDecoder.decodeBool(forKey: SerializationKeys.geometrySimplify)
    self.units = aDecoder.decodeObject(forKey: SerializationKeys.units) as? String
    self.geometryFormat = aDecoder.decodeObject(forKey: SerializationKeys.geometryFormat) as? String
    self.language = aDecoder.decodeObject(forKey: SerializationKeys.language) as? String
    self.coordinates = aDecoder.decodeObject(forKey: SerializationKeys.coordinates) as? [[ Double]]
    self.instructionsFormat = aDecoder.decodeObject(forKey: SerializationKeys.instructionsFormat) as? String
    self.profile = aDecoder.decodeObject(forKey: SerializationKeys.profile) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(geometry, forKey: SerializationKeys.geometry)
    aCoder.encode(instructions, forKey: SerializationKeys.instructions)
    aCoder.encode(preference, forKey: SerializationKeys.preference)
    aCoder.encode(elevation, forKey: SerializationKeys.elevation)
    aCoder.encode(geometrySimplify, forKey: SerializationKeys.geometrySimplify)
    aCoder.encode(units, forKey: SerializationKeys.units)
    aCoder.encode(geometryFormat, forKey: SerializationKeys.geometryFormat)
    aCoder.encode(language, forKey: SerializationKeys.language)
    aCoder.encode(coordinates, forKey: SerializationKeys.coordinates)
    aCoder.encode(instructionsFormat, forKey: SerializationKeys.instructionsFormat)
    aCoder.encode(profile, forKey: SerializationKeys.profile)
  }

}
