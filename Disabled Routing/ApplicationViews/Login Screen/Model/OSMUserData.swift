//
//  OSMWayData.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 06/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import EVReflection
class OSMUser: EVObject {
    public var user: User?
}
class User: EVObject {
    public var _id: String?
    public var _display_name: String?
}
