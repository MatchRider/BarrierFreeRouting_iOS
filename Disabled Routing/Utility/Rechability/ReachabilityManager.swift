

import UIKit
import Reachability

class ReachabilityManager: NSObject{
    
    //Shared instance
    static  let shared = ReachabilityManager()

    //Boolean to track network reachability
    var isNetworkAvailable : Bool! = false
    
    //Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
            
        case .none:
            isNetworkAvailable = false
            debugPrint("Network became unreachable")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.NSNotificationNames.INTERNET_UNREACHABLE_NOTIFICATION), object: nil, userInfo: nil)
            
        case .wifi:
            isNetworkAvailable = true
            debugPrint("Network reachable through WiFi")
            NotificationCenter.default.post(name:  AppConstants.NSNotificationNames.INTERNET_RECHABLE_NOTIFICATION, object: nil, userInfo: nil)
            
        case .cellular:
            isNetworkAvailable = true
            debugPrint("Network reachable through Cellular Data")
            NotificationCenter.default.post(name: AppConstants.NSNotificationNames.INTERNET_RECHABLE_NOTIFICATION, object: nil, userInfo: nil)
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }

}
