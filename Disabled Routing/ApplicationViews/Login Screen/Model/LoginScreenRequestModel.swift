//
//  LoginScreenRequestModel
//
//  Created by  on 7/28/18
//  Copyright (c) . All rights reserved.
//

import Foundation

struct LoginScreenRequestModel {
    var sourceInfo      : (Double?,Double?,String?)
    var destinationInfo : (Double?,Double?,String?)
    var fromLat         : Double!
    var fromLong        : Double!
    var toLat           : Double!
    var toLong          : Double!
}
