/**
 
 */

import UIKit

@IBDesignable
class CustomButton: UIButton
{
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var corderRadius: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.appThemeColor()
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = corderRadius
        self.layer.masksToBounds = true
    }
}
