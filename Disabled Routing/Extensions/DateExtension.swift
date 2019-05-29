//
//  DateExtension.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 18/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import Foundation

extension Date{
    func getUTCFormateDate() -> String {
        let dateFormatter = DateFormatter()
        let timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateString: String = dateFormatter.string(from: self)
        return dateString
    }
}
