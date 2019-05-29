
//Notes: - This is an extension for ui font basically manages the font size for varible screen size

import UIKit


extension UIFont{
    
    
    /**
     This get SanFrancisco Regular font with size
     
     - parameter size: CGFloat 
     
     - returns : UIFont
     */
    
    class func getFrutigerLight(withSize size:CGFloat)->UIFont {
        
        if let font = UIFont(name: "FrutigerLTStd-Light", size: size){
            return font
        }
        return .systemFont(ofSize: size)
    }

    /**
     This get SanFrancisco Light font with size
     
     - parameter size: CGFloat
     
     - returns : UIFont
     */
    //"FrutigerLTStd-Light", "FrutigerLTStd-Bold"
    class func getFrutigerBold(withSize size:CGFloat)->UIFont {
        
        if let font = UIFont(name: "FrutigerLTStd-Bold", size: size){
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    /**
     This get SanFrancisco Light font with size
     
     - parameter size: CGFloat
     
     - returns : UIFont
     */
    
    class func getSanFranciscoSemibold(withSize size:CGFloat)->UIFont {
        
        if let font = UIFont(name: "Titillium-Semibold", size: size){
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    /**
     This get SanFrancisco Light font with size
     
     - parameter size: CGFloat
     
     - returns : UIFont
     */
    
    class func getSanFranciscoBold(withSize size:CGFloat)->UIFont {
        
        if let font = UIFont(name: "Titillium-Bold", size: size){
            return font
        }
        return .systemFont(ofSize: size)
    }
    
    /**
     This get Titillium Semibold  font with size
     
     - parameter size: CGFloat
     
     - returns : UIFont
     */
    
    class func getTitilliumSemibold(withSize size:CGFloat)->UIFont {
        
        if let font = UIFont(name: "Titillium-Semibold", size: size){
            return font
        }
        return .systemFont(ofSize: size)
    }
    
}
