/*
 This class render View with border
 */

import UIKit

@IBDesignable
class UIBorderView: UIView
{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}

extension UIView{
    
    func addShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func addDropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


extension UIView{
    
    /**
     This method is used to make the view circular
     */
    func makeViewCircular(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    /**
     This method is used to set corner radius to a view with given width
     
     -parameter width : CGFloat
     
     -returns : Void
     */
    func setCornerCircular(_ width:CGFloat) -> Void {
        self.layer.cornerRadius = width
        self.layer.masksToBounds = true
    }
    
    
    /**
     This method is used to border to the view with given color and broder width
     
     -parameter width: CGFloat
     -parameter color: UIColor default value .white
     
     - returns : Void
     */
    
    func setBorderToView(withWidth width:CGFloat,color:UIColor = .white) -> Void {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyHorizontalGradient(){
        let diagonalMode = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.bounds.size
        gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [UIColor.purple.cgColor,UIColor.blue.cgColor]
        gradientLayer.locations = [0.5,1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyVerticalGradient(){
        let diagonalMode = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [UIColor.white.cgColor,UIColor.clear.cgColor]
        gradientLayer.locations = [0.4,1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    /**
     This method is used to end the superview editing.
     
     - returns : Void
     */
    func endSuperViewEditing() ->Void{
        self.superview!.endEditing(true)
    }
    
    /**
     This method is used to end the view editing.
     
     - returns : Void
     */
    func endViewEditing() ->Void{
        self.endEditing(true)
    }
}

