
//Note:- This class contains color code of specific colors

import UIKit


extension UIColor{
    
    static func appThemeColor() -> UIColor {
        return UIColor(red: 165/255.0, green: 0/255.0, blue: 80/255.0, alpha: 1.0)
    }
   static func randomHexColorCode() -> String{
        let a = ["1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
        return "#".appending(a[Int(arc4random_uniform(15))]).appending(a[Int(arc4random_uniform(15))]).appending(a[Int(arc4random_uniform(15))]).appending(a[Int(arc4random_uniform(15))]).appending(a[Int(arc4random_uniform(15))]).appending(a[Int(arc4random_uniform(15))])
    }
}
