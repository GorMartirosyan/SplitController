//
//  AppDelegate.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let masterStoryBoard: UIStoryboard = UIStoryboard(name: "Master", bundle: nil)
        let firstNav = masterStoryBoard.instantiateViewController(withIdentifier: "navMasterController") as! UINavigationController
        
        let detailStoryBoard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let secondNav = detailStoryBoard.instantiateViewController(withIdentifier: "navDetailController") as! UINavigationController
        
        
        let splitController = UISplitViewController()
        splitController.viewControllers = [firstNav, secondNav]
        splitController.preferredDisplayMode = UISplitViewController.DisplayMode(rawValue: 2)!
        splitController.delegate = self
        
        self.window?.rootViewController = splitController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
}

extension AppDelegate : UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        svc.view.setNeedsLayout()
    }
}

