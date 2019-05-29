
//Note:- This extension is used to get object for various storyBoards.

import UIKit

extension UIStoryboard {
    
    enum Storyboard:String{
        case Main
        case Walkthrough
        var object: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle.main)
        }
    }
}

//Note:- This extension is used to get object for view controller with identifier.

extension UIViewController{
    
    /**
     Get object for view controller of Type T for storyboard.
     - parameter  ofType : T type argument basically it is a name of UIViewController
     - parameter storyboard : UIStoryboard
     - return    : returns T(UIViewController object of type T)
     */
    class func getViewController<T:UIViewController>(_ ofType:T.Type,storyboard:UIStoryboard)->T{
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    /**
     Get object for view controller of Type T for main story board.
     - parameter  ofType : T type argument basically it is a name of UIViewController
     - return    : returns T(UIViewController object of type T)
     */
    class func getViewController<T:UIViewController>(viewController ofType:T.Type)->T{
        return UIStoryboard.Storyboard.Main.object.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}


