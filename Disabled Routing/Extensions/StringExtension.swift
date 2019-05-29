
//MARK: This class contains basic String manipultaion methods

import UIKit


extension String{
    
    /**
     This methods checks whether string lenght is greater than zero or not
     
     - returns: Bool value true if empty otherwise it returns false
     */
    

    func isEmptyString () -> Bool
    {
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if(str.characters.count==0){
            return true
        }
        
        return false
    }
 
    
    /**
     This methods checks whether email id is Valid or not
     
     - returns: Bool Value true if emailId is valid otherwise return false
     */
    
    func isValidEmailId() ->Bool
    {
        
        let emailRegEx = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /**
     This method checks whether password is Valid or not
     
     - returns: Bool Value true if Password is valid otherwise return false
     */
    
    func isPasswordValid()->Bool
    {
        // For at least 6 characters ^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$
        /// no max char check ^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$
        
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if(str.characters.count>=6 && str.characters.count<=25){
            return true
        }
        return false
    }
    
    func isOTPValid()->Bool
    {
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if(str.characters.count==6){
            return true
        }
        return false
    }
    
    /**
     This method checks whether phone number is Valid or not
     
     - returns: Bool Value true if phone number is valid otherwise return false
     */
    func isPhoneNumberValid() -> Bool {
        let phoneRegEX = "^(\\+\\d{1,3}[- ]?)?\\d{10,14}$"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEX)
        return phoneTest.evaluate(with: self)
    }
    
    func getPhoneNumberFormat() -> String {
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return str
    }
    
    /**
     This method checks whether zip code is Valid or not
     
     - returns: Bool Value true if phone number is valid otherwise return false
     */
    func isValidZipCode() -> Bool {
        
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let decimalDigitsSet = CharacterSet.decimalDigits
        
        var flag = true
        
        for c in str.unicodeScalars {
            if !decimalDigitsSet.contains(c) {
                flag = false
            }
        }

        if(str.characters.count==5 && flag){
            return true
        }
        return false
    }
    
    func isNameValid()->Bool{
        let nameRegex = "^[\\p{L} .']+$"
        let validNameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return validNameTest.evaluate(with: self)
    }
    
    /***/
    func setPhoneNumber() ->String? {
        
        let countryCode = "" //AppDelegate.sharedInstance.userInformation.countryCode
        var inputStr = self
        
        var strUpdated = inputStr
        if inputStr.characters.count == 10 {
            strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 3))
            strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 7))
        }
        
        strUpdated = countryCode + " " + strUpdated
        
        return strUpdated
    }
    
    func getWhitespaceTrimmedString()->String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func capitalizeWordsInSentence()->String{
        var wordsFromSentence = self.components(separatedBy: " ")
        if wordsFromSentence.count > 0{
            for (index, eachWord) in wordsFromSentence.enumerated(){
                if !eachWord.isEmpty{
                    let firstIndexOffset = eachWord.index(eachWord.startIndex, offsetBy: 1)
                    let captalizeWord = eachWord.substring(to: firstIndexOffset).uppercased() + eachWord.substring(from: firstIndexOffset)
                    wordsFromSentence[index] = captalizeWord
                }
            }
        }
        
        return wordsFromSentence.joined(separator: " ")
    }
    func getDateFromZoneFormate() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    
        
        /**
         This method calculates the dynamic height of label according to the context.
         
         - parameter str:   text to be set on the label
         - parameter font:  corresponding font for the label
         - parameter width: width of the label
         
         - returns: returns dynamic height for the label.
         */
        
        func calculateHeightForLabel(str:String , forFont font:UIFont) ->CGFloat
        {
            let lblTitle:UILabel = UILabel()
            lblTitle.numberOfLines = 0
            lblTitle.lineBreakMode = NSLineBreakMode.byWordWrapping;
            lblTitle.text = str
            lblTitle.font = font
            var size:CGSize = CGSize()
            size = lblTitle.sizeThatFits(CGSize(width: lblTitle.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            return size.height
        }
    
    func heightForView(font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}
