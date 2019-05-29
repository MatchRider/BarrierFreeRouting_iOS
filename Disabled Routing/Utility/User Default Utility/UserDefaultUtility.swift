
//MARK: This Class contains User Default Utility methods

import UIKit

class UserDefaultUtility: NSObject {
    
    class func saveStringWithKey(_ message: String, key: String){
        let defaults = UserDefaults.standard
        defaults.set(message, forKey: key)
        defaults.synchronize()
    }
    class func retrieveStringWithKey(_ key: String)-> String{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key) as! String
    }
    class func removeStringWithKey(_ key: String){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    class func saveObjectWithKey(_ object: AnyObject, key: String){
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
    
    class func retrievObjectWithKey(_ key: String)-> AnyObject{
        if let keys:String = key  {
            let defaults = UserDefaults.standard
            if let value = defaults.object(forKey: keys){
                return value as AnyObject
            }
        }
        return "" as AnyObject
    }
    
    class  func removeObjectWithKey(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    class func objectAlreadyExist(_ key: String) -> Bool {
        let userDefaults : UserDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: key) != nil) {
            return true
        }
        return false
    }
    
    class func saveBoolForKey(_ key: String, value: Bool){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    class func retrieveBoolForKey(_ key: String) -> Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)        
    }
    
    class func removeAllUserDefault(){
       
    }
}
