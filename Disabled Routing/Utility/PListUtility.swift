
//Notes:- This class is used to get value for key present in plist

import Foundation

class PListUtility{
    
    class func getValue(forKey: String)->Any{
        guard let infoDict = Bundle.main.infoDictionary?[forKey] else{
            NSLog("Value for \(forKey) not found in info.plist.Please Add if you want to acess it")
            return Bundle.main.infoDictionary![forKey]!
        }
        return infoDict
    }
}

