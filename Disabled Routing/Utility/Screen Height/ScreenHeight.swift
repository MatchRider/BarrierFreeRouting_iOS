
//Note :- This class contains enum containing Static height and Width of our devices

import Foundation
import UIKit

struct ScreenHeight{
    static let Iphone6Plus = 736
    static let Iphone6 = 667
    static let Iphone5 = 568

}

struct ScreenWidth{
    static let Iphone6Plus = 414
    static let Iphone6 = 375
    static let Iphone5 = 320
    
}

struct ScreenSize{
    static let size = UIScreen.main.bounds.size
    
}
