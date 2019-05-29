//
//  NodesResponseModel.swift
//
//  Created by  on 29/03/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class NodesResponseModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let nodes = "nodes"
  }

  // MARK: Properties
  public var nodes: [Nodes]?

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
    nodes <- map[SerializationKeys.nodes]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = nodes { dictionary[SerializationKeys.nodes] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.nodes = aDecoder.decodeObject(forKey: SerializationKeys.nodes) as? [Nodes]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(nodes, forKey: SerializationKeys.nodes)
  }

}
