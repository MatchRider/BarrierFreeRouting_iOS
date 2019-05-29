
//
//  APNSManager.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 15/09/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import LGSideMenuController
enum PUSH_EVENTS : String
{
    case EVT_BID_NEW                = "EVT_BID_NEW"
    case EVT_BID_DRIVER_COUNTER     = "EVT_BID_DRIVER_COUNTER"
    case EVT_BID_DRIVER_ACCEPT      = "EVT_BID_DRIVER_ACCEPT"
    case EVT_BID_DRIVER_REJECT      = "EVT_BID_DRIVER_REJECT"
    case EVT_BID_RIDER_ACCEPT       = "EVT_BID_RIDER_ACCEPT"
    case EVT_BID_RIDER_REJECT       = "EVT_BID_RIDER_REJECT"
    case EVT_BID_RIDER_COUNTER      = "EVT_BID_RIDER_COUNTER"
    case EVT_DRIVER_APPROVED        = "EVT_DRIVER_APPROVED"
    case EVT_DRIVER_DISAPPROVED     = "EVT_DRIVER_DISAPPROVED"
    case EVT_USER_ENABLE            = "EVT_USER_ENABLE"
    case EVT_USER_DISABLE           = "EVT_USER_DISABLE"
    case EVT_DRIVER_TRIP_CANCELLED  = "EVT_DRIVER_TRIP_CANCELLED"
    case EVT_RIDER_TRIP_CANCELLED   = "EVT_RIDER_TRIP_CANCELLED"
    case EVT_DRIVER_TRIP_STARTED    = "EVT_DRIVER_TRIP_STARTED"
    case EVT_DRIVER_ARRIVED         = "EVT_DRIVER_ARRIVED"
    case DRIVER_TRIP_ENDED          = "EVT_DRIVER_TRIP_ENDED"
    case RIDER_ADDED_STOP           = "EVT_RIDER_ADDED_STOP"
    case DRIVER_VISITED_STOP        = "EVT_DRIVER_VISITED_STOP"
    case PAYMENT_SUCCESS            = "EVT_PAYMENT_SUCCESS"
    case EVT_PICK_UP_STARTED        = "EVT_PICK_UP_STARTED"

}

enum TRIP_STATUS : String
{
    case STARTED                = "STARTED"
    case CONFIRMED              = "CONFIRMED"
    case CANCELLED              = "CANCELLED"
    case ENDED                  = "ENDED"
    case EXPIRED                = "EXPIRED"
}
class APNSManager: NSObject{
    
    static let sharedInstance = APNSManager()
    
    private override init(){}
    
    
    /// This method is used to register app for recieving push notification with settings
    func registerForPushNotification(){
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    /// This method is used to handle notification payload if user launch app from backgroud or from new instance
    ///
    /// - Parameter options: launch options dictionary
    func handleNotificationPayloadOnLaunch(withLaunchOptions options: [UIApplication.LaunchOptionsKey: Any]?){
        if let dict = options?[UIApplication.LaunchOptionsKey.remoteNotification]{
            self.onRecievingPushNotification(withPayload: dict as! NSDictionary)
        }
    }
    
    
    /// This method is called when device is successfully registred with APNS server and server responds with device token for the app
    ///
    /// - Parameter withDeviceToken: Device token in string format
    func onRegistrationSuccess(withDeviceToken deviceToken: String){
        UserDefaultUtility.saveStringWithKey(deviceToken, key: AppConstants.UserDefaultKeys.DEVICE_TOKEN)
    }
    
    
    /// This method is called when device recieve any push notifcation from APNS server
    ///
    /// - Parameter data: data representing payload of recieved notification
    func onRecievingPushNotification(withPayload data: NSDictionary){
        
    }
    
//    func handleNotificationEvent(_ objNotification:PushNotificationObjectModel)
//    {
////        switch objNotification.eventName! {
////        }
//    }
}
