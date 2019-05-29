//
//  PlacesProperties.swift
//
//  Created by Hürdenlose Navigation on 11/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PlacesProperties: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let country = "country"
    static let source = "source"
    static let regionGid = "region_gid"
    static let countryA = "country_a"
    static let sourceId = "source_id"
    static let continentGid = "continent_gid"
    static let continent = "continent"
    static let macrocounty = "macrocounty"
    static let id = "id"
    static let region = "region"
    static let postalcode = "postalcode"
    static let localityGid = "locality_gid"
    static let name = "name"
    static let countyGid = "county_gid"
    static let street = "street"
    static let accuracy = "accuracy"
    static let label = "label"
    static let locality = "locality"
    static let housenumber = "housenumber"
    static let layer = "layer"
    static let macrocountyGid = "macrocounty_gid"
    static let gid = "gid"
    static let countryGid = "country_gid"
    static let county = "county"
    static let confidence = "confidence"
  }

  // MARK: PlacesProperties
  public var country: String?
  public var source: String?
  public var regionGid: String?
  public var countryA: String?
  public var sourceId: String?
  public var continentGid: String?
  public var continent: String?
  public var macrocounty: String?
  public var id: String?
  public var region: String?
  public var postalcode: String?
  public var localityGid: String?
  public var name: String?
  public var countyGid: String?
  public var street: String?
  public var accuracy: String?
  public var label: String?
  public var locality: String?
  public var housenumber: String?
  public var layer: String?
  public var macrocountyGid: String?
  public var gid: String?
  public var countryGid: String?
  public var county: String?
  public var confidence: Float?

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
    country <- map[SerializationKeys.country]
    source <- map[SerializationKeys.source]
    regionGid <- map[SerializationKeys.regionGid]
    countryA <- map[SerializationKeys.countryA]
    sourceId <- map[SerializationKeys.sourceId]
    continentGid <- map[SerializationKeys.continentGid]
    continent <- map[SerializationKeys.continent]
    macrocounty <- map[SerializationKeys.macrocounty]
    id <- map[SerializationKeys.id]
    region <- map[SerializationKeys.region]
    postalcode <- map[SerializationKeys.postalcode]
    localityGid <- map[SerializationKeys.localityGid]
    name <- map[SerializationKeys.name]
    countyGid <- map[SerializationKeys.countyGid]
    street <- map[SerializationKeys.street]
    accuracy <- map[SerializationKeys.accuracy]
    label <- map[SerializationKeys.label]
    locality <- map[SerializationKeys.locality]
    housenumber <- map[SerializationKeys.housenumber]
    layer <- map[SerializationKeys.layer]
    macrocountyGid <- map[SerializationKeys.macrocountyGid]
    gid <- map[SerializationKeys.gid]
    countryGid <- map[SerializationKeys.countryGid]
    county <- map[SerializationKeys.county]
    confidence <- map[SerializationKeys.confidence]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = regionGid { dictionary[SerializationKeys.regionGid] = value }
    if let value = countryA { dictionary[SerializationKeys.countryA] = value }
    if let value = sourceId { dictionary[SerializationKeys.sourceId] = value }
    if let value = continentGid { dictionary[SerializationKeys.continentGid] = value }
    if let value = continent { dictionary[SerializationKeys.continent] = value }
    if let value = macrocounty { dictionary[SerializationKeys.macrocounty] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = region { dictionary[SerializationKeys.region] = value }
    if let value = postalcode { dictionary[SerializationKeys.postalcode] = value }
    if let value = localityGid { dictionary[SerializationKeys.localityGid] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = countyGid { dictionary[SerializationKeys.countyGid] = value }
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = accuracy { dictionary[SerializationKeys.accuracy] = value }
    if let value = label { dictionary[SerializationKeys.label] = value }
    if let value = locality { dictionary[SerializationKeys.locality] = value }
    if let value = housenumber { dictionary[SerializationKeys.housenumber] = value }
    if let value = layer { dictionary[SerializationKeys.layer] = value }
    if let value = macrocountyGid { dictionary[SerializationKeys.macrocountyGid] = value }
    if let value = gid { dictionary[SerializationKeys.gid] = value }
    if let value = countryGid { dictionary[SerializationKeys.countryGid] = value }
    if let value = county { dictionary[SerializationKeys.county] = value }
    if let value = confidence { dictionary[SerializationKeys.confidence] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.regionGid = aDecoder.decodeObject(forKey: SerializationKeys.regionGid) as? String
    self.countryA = aDecoder.decodeObject(forKey: SerializationKeys.countryA) as? String
    self.sourceId = aDecoder.decodeObject(forKey: SerializationKeys.sourceId) as? String
    self.continentGid = aDecoder.decodeObject(forKey: SerializationKeys.continentGid) as? String
    self.continent = aDecoder.decodeObject(forKey: SerializationKeys.continent) as? String
    self.macrocounty = aDecoder.decodeObject(forKey: SerializationKeys.macrocounty) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.region = aDecoder.decodeObject(forKey: SerializationKeys.region) as? String
    self.postalcode = aDecoder.decodeObject(forKey: SerializationKeys.postalcode) as? String
    self.localityGid = aDecoder.decodeObject(forKey: SerializationKeys.localityGid) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.countyGid = aDecoder.decodeObject(forKey: SerializationKeys.countyGid) as? String
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.accuracy = aDecoder.decodeObject(forKey: SerializationKeys.accuracy) as? String
    self.label = aDecoder.decodeObject(forKey: SerializationKeys.label) as? String
    self.locality = aDecoder.decodeObject(forKey: SerializationKeys.locality) as? String
    self.housenumber = aDecoder.decodeObject(forKey: SerializationKeys.housenumber) as? String
    self.layer = aDecoder.decodeObject(forKey: SerializationKeys.layer) as? String
    self.macrocountyGid = aDecoder.decodeObject(forKey: SerializationKeys.macrocountyGid) as? String
    self.gid = aDecoder.decodeObject(forKey: SerializationKeys.gid) as? String
    self.countryGid = aDecoder.decodeObject(forKey: SerializationKeys.countryGid) as? String
    self.county = aDecoder.decodeObject(forKey: SerializationKeys.county) as? String
    self.confidence = aDecoder.decodeObject(forKey: SerializationKeys.confidence) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(regionGid, forKey: SerializationKeys.regionGid)
    aCoder.encode(countryA, forKey: SerializationKeys.countryA)
    aCoder.encode(sourceId, forKey: SerializationKeys.sourceId)
    aCoder.encode(continentGid, forKey: SerializationKeys.continentGid)
    aCoder.encode(continent, forKey: SerializationKeys.continent)
    aCoder.encode(macrocounty, forKey: SerializationKeys.macrocounty)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(region, forKey: SerializationKeys.region)
    aCoder.encode(postalcode, forKey: SerializationKeys.postalcode)
    aCoder.encode(localityGid, forKey: SerializationKeys.localityGid)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(countyGid, forKey: SerializationKeys.countyGid)
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(accuracy, forKey: SerializationKeys.accuracy)
    aCoder.encode(label, forKey: SerializationKeys.label)
    aCoder.encode(locality, forKey: SerializationKeys.locality)
    aCoder.encode(housenumber, forKey: SerializationKeys.housenumber)
    aCoder.encode(layer, forKey: SerializationKeys.layer)
    aCoder.encode(macrocountyGid, forKey: SerializationKeys.macrocountyGid)
    aCoder.encode(gid, forKey: SerializationKeys.gid)
    aCoder.encode(countryGid, forKey: SerializationKeys.countryGid)
    aCoder.encode(county, forKey: SerializationKeys.county)
    aCoder.encode(confidence, forKey: SerializationKeys.confidence)
  }

}
