//
//  AppUtility.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 26/07/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import UIKit
class AppUtility{
    
    
    /// This function returns formatted dialling code
    ///
    /// - Parameter code: dialling code with sign i.e. +91
    /// - Returns: formatted dialing code
    
    
    class func getFormattedDiallingCodeFromCode(code: String)->String{
        let offsetIndex = code.index(code.startIndex, offsetBy: 1)
        return code.substring(from: offsetIndex)
    }
    
    //MARK:- Methods to present toasts.
    
    /**
     This method is used to present toast with given message string and default delay & duration
     - parameter message: The text to be shown in the toast
     */
    class func presentToastWithMessage(_ message:String){
//        let toast = Toast(text: message)
//        toast.show()
    }
    
    /**
     This method is used to present toast with given message string & duration but default delay
     - parameter message: The text to be shown in the toast
     - parameter duration: The duration for which toast is shown
     */
    class func presentToastWithMessageAndDuration(_ message:String,duration:Double){
//        let toast = Toast(text: message,duration: duration)
//        toast.show()
    }
    
    /**
     This method is used to present toast with given message string & duration but default delay
     - parameter message: The text to be shown in the toast
     - parameter duration: The duration for which toast is shown
     - parameter delay: The delay time after which toast will be shown
     */
    class func presentToastWithMessageDurationAndDelay(_ message:String,duration:Double,delay: Double){
//        let toast = Toast(text: message,delay: delay,duration: duration)
//        toast.show()
    }
    
    
    /// Check if user is login or not
    ///
    /// - Returns: User login status
    class func isUserLogin()->Bool{
        return checkKeyInUserDefault(key: AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN)
    }
    
    /**
     * This method is used for checking particular in User Default
     * parameter : String Object
     * @returns  : Bool
     */
    
    class func checkKeyInUserDefault(key:String) -> Bool {
        if(UserDefaultUtility.retrieveBoolForKey(key) == true) {
            
            if (UserDefaultUtility.objectAlreadyExist(key) == true){
                return true
            }
            return false
        }
        return false
    }
    
    
    /// Calculate cab timing in minutes
    ///
    /// - Parameter ms: time in miliseconds
    /// - Returns: time in minutes i.e. 1 min
    class func getTimeInMinutes(fromTimeInMS ms: UInt64)->String{
        
        let seconds = ms / 1000
        var minute = (seconds % 3600) / 60
        let hour = seconds / 3600
        
        //Automatically set 1 min if found 0 anywhere...
        if minute == 0{
            minute = 1
        }
        
        var time = "\(minute) min"
        
        if hour != 0{
            time = "\(hour) h \(minute) m"
        }
        
        return time
    }
    
    
    /// Make image url from image id
    ///
    /// - Parameter id: string parameter as image id
    /// - Returns: string image url to get image direclty
    class func getImageURL(fromImageId id: String)->String{
        return "\(AppConstants.URL.BASE_URL)/files/\(id)?api_key=\(AppConstants.APIRequestHeaders.API_KEY_VALUE)"
    }
    
    class func getFormattedPriceString(withPrice price: Double)->String{
        return  String(format: "$%.2f", price)
    }
    
    class func getFormattedDistance(withDistance distance: Int)->String{
        return  String(format: "%.1f km", (distance/1000))
    }
    
    class func getFormattedTimeDuration(withTime time: Int)->String{
        return  String(format: "%d min", (time/60000))
    }
    
    class func getDateFromUTCFormat(dateStr: String, format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        let calendar = NSCalendar.current
        let now = Date()
        let components = calendar.dateComponents([Calendar.Component.hour,Calendar.Component.minute], from: now, to: date)
        if components.hour! >= 0 && components.hour! <= 12 {
            if components.hour! == 0{
              return "Exp. in \(components.minute!) min"
            }
            return "Exp. in \(components.hour!) hours"
        }
        else{
            return AppUtility.getFormattedDate(withFormat: format, date: date)
        }
    }
    
    class func getDateFromUTCFormatSearchList(dateStr: String, format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")

        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        
        return AppUtility.getFormattedDate(withFormat: format, date: date)
    }
    
    class func getDateForFilter(dateStr: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")

        guard let date = dateFormatter.date(from: dateStr) else { return "" }
        let now = Date()
        
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd"
        let selectedDateStr = formate.string(from: date)
        let todayDateStr = formate.string(from: now)
        
        
        if selectedDateStr == todayDateStr{
            return "Today at \(AppUtility.getFormattedDate(withFormat: "h:mm a", date: date))"
        }else{
            return AppUtility.getFormattedDate(withFormat: "EEE MMM, dd", date: date) + " at " + AppUtility.getFormattedDate(withFormat: "h:mm a", date: date)
        }
      
        
//        if components.hour! >= 0 && components.hour! <= 24 {
//            return "Today at \(AppUtility.getFormattedDate(withFormat: "h:mm a", date: date))"
//        }
//        else{
//            return AppUtility.getFormattedDate(withFormat: "EEE MMM, dd", date: date) + " at " + AppUtility.getFormattedDate(withFormat: "h:mm a", date: date)
//        }
    }

    
    
    /// Format date with given format
    ///
    /// - Parameters:
    ///   - format: string date format
    ///   - date: Date to be formatted
    /// - Returns: Formatted date string
    class func getFormattedDate(withFormat format: String, date: Date)->String{
        let dateFormatter = DateFormatter()
        //Set Locale
        let enUSPOSIXLocale: Locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        //Set Formatter
        dateFormatter.dateFormat = format
        //Get Formatted Date
        let dateInString = dateFormatter.string(from: date)
        return dateInString
    }    
    
    /// This method is used to open phone dialler with number
    ///
    /// - Parameter phoneNumber: phoneNumber to dial
    class func callNumber(phoneNumber:String) {
        if let phoneCallURL:URL = URL(string: "tel:\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    /// This method is used to open SMS app
    ///
    /// - Parameter phoneNumber: phoneNumber to sent sms
    class func messageNumber(phoneNumber:String) {
        if let phoneCallURL:URL = URL(string: "sms:\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    class func openAppUrl(appUrl:String,webUrl:String) {
        if let appURL:URL = URL(string: appUrl) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(appURL as URL)) {
                application.open(appURL, options: [:], completionHandler: nil)
            }
            else
            {
                application.open(URL(string: webUrl)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    class func getFormattedTimeDuration(fromTimeStamp timeStamp:String)->String
    {
        
        let dateFormatter = DateFormatter()
       // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = Locale.current

        let calendar = NSCalendar.current
        let ratedOnDate = timeStamp.getDateFromZoneFormate()
        
        if calendar.isDateInToday(ratedOnDate)
        {
            dateFormatter.dateFormat = "h:mm a"
            return String(format:"Today, %@",dateFormatter.string(from: ratedOnDate).lowercased())
        }
        else if calendar.isDateInYesterday(ratedOnDate)
        {
            dateFormatter.dateFormat = "h:mm a"
            return String(format:"Yesterday, %@",dateFormatter.string(from: ratedOnDate).lowercased())
        }
        else
        {
            dateFormatter.dateFormat = "MMM dd yyy"
            let dateString = dateFormatter.string(from: ratedOnDate)
            dateFormatter.dateFormat = "h:mm a"
            let timeString = dateFormatter.string(from: ratedOnDate).lowercased()
            return String(format:"%@, %@",dateString,timeString)
        }
    }
    
    
//    class func showCustomAlert(title: String, message: String, presentingVC: UIViewController, actionItems: [UIAlertAction] = []){
//
//        let alertController = UIAlertController(title: title , message:
//            message, preferredStyle: .alert)
//
//
//        if actionItems.count > 0{
//            alertController.addActions(actionItems)
//        }
//        else{
//            alertController.addAction(UIAlertAction(title: AppConstants.ScreenSpecificConstant.Common.OK_TITLE , style: .cancel,handler: nil))
//        }
//
//        presentingVC.present(alertController, animated: true, completion: nil)
//    }
//
    class func getTripDateFromDateString(_ date: String)-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        let rideDate = dateFormatter.date(from: date)
       
        dateFormatter.timeZone =  TimeZone.current
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        dateFormatter.dateFormat = "MMM, yyyy, h:mma"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        let dateStrTmp = dateFormatter.string(from: rideDate!)
        
        let calendar = Calendar(identifier: .gregorian)
        let dayTmp = calendar.component(.day, from: rideDate!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let dayStr =  formatter.string(from: NSNumber(value: dayTmp))
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let rideDateStr = dateFormatter.string(from: rideDate!)
        let todayDateStr = dateFormatter.string(from: Date())
        let rideDateTmp = dateFormatter.date(from: rideDateStr)
        let todayDateTmp = dateFormatter.date(from: todayDateStr)
        let tomorrowDateTmp = Calendar.current.date(byAdding: .day, value: 1, to: todayDateTmp!)!
        let yeterdayDateTmp = Calendar.current.date(byAdding: .day, value: -1, to: todayDateTmp!)!
        
        var completeRideDate = ""
        dateFormatter.dateFormat = "h:mma"
        let time = dateFormatter.string(from: rideDate!)
        
        if rideDateTmp == yeterdayDateTmp{
            completeRideDate = "Yesterdy, \(time)"
        }else if rideDateTmp == todayDateTmp{
            completeRideDate = "Today, \(time)"
        }else if rideDateTmp == tomorrowDateTmp{
            completeRideDate = "Tomorrow, \(time)"
        }else{
            completeRideDate = "\(dayStr!) \(dateStrTmp)"
        }
        return completeRideDate
    }
    
    class func getDriverApproxDriveTime (_ milliSeconds : UInt64, hourStyle: String = "H", mintStyle: String = "MIN", endMsg: String = "") -> String {

    let seconds = milliSeconds / 1000
    let minute = (seconds % 3600) / 60
    let hour = seconds / 3600
     var time = "\(minute) \(mintStyle) \(endMsg)"
    if hour != 0{
        time = "\(hour) \(hourStyle) \(minute) \(mintStyle) \(endMsg)"
    }
    return time
    }
     class func getTripDistanceInMiles (_ distanceMeter : Int) -> String {
        let distanceInMiles = "\( String(format:"%.1f",Double(distanceMeter)/1609.344))"
        return distanceInMiles
    }
    //%.3f
    
    
    /**
     This method is used to get date in Date format from string format
     - parameter message: date in String format
     */
    class func getDateFromString(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")
        let date = dateFormatter.date(from: dateStr)
        return date
        
    }
}
