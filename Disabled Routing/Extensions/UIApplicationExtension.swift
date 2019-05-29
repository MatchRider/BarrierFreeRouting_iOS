//
//  UIApplicationExtension.swift
//  Hürdenlose Navigation
//
//  Created by Daffolapmac on 10/10/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//
import UIKit
import LGSideMenuController
import JHTAlertController
extension UIApplication {
    
    var visibleViewController: UIViewController? {
        
        guard let rootViewController = keyWindow?.rootViewController else {
            return nil
        }
        
        return getVisibleViewController(rootViewController)
    }
    var rootViewController: UIViewController? {
        
        guard let _ = keyWindow?.rootViewController else {
            return nil
        }
        
        return keyWindow?.rootViewController
    }
    
    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let lgSideMenuController = rootViewController as? LGSideMenuController {
            return getVisibleViewController(lgSideMenuController.rootViewController!)
        }
        return rootViewController
    }
    func getViewControllerToUpdate<T:BaseViewController>(_ rootViewController: UIViewController,toUpdate viewController:T.Type) -> UIViewController? {
        
        if let presentedViewController = rootViewController.presentedViewController {
            return self.getViewControllerToUpdate(presentedViewController,toUpdate: viewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return self.getNotifiedViewControllerFromNavigationController(navigationController,toUpdate: viewController)
        }
        
        if let lgSideMenuController = rootViewController as? LGSideMenuController {
           return self.getViewControllerToUpdate(lgSideMenuController.rootViewController!,toUpdate: viewController)
            //return getVisibleViewController(lgSideMenuController.rootViewController!)
        }
        return rootViewController
    }
    private func getNotifiedViewControllerFromNavigationController<T:UIViewController>(_ navigationController : UINavigationController,toUpdate viewController:T.Type) -> UIViewController
    {
        for vc in navigationController.viewControllers
        {
            if vc.isKind(of: viewController)
            {
                return vc
            }
            
        }
        return navigationController.visibleViewController!
    }
}
