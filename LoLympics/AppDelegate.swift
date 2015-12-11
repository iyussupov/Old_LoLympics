//
//  AppDelegate.swift
//  LoLympics
//
//  Created by Dev1 on 11/30/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import DrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController: DrawerController!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("DWyFUzP1IVWsazJyqA1q0NwLMdTPyTo4ypLNxzKg", clientKey: "wjw3nYXfyejxTIc1sFLkLS80h7lO8GUFJTuVID8H")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let navigationController = UINavigationController()
        
        //let loginViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LogInVC") as! LogInVC
        
        let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        
        let rightSideNavController = mainStoryboard.instantiateViewControllerWithIdentifier("RightSideVC") as! RightSideVC
        
        let leftSideNavController = mainStoryboard.instantiateViewControllerWithIdentifier("LeftSideVC") as! LeftSideVC
        
        let leftSideNav = UINavigationController(rootViewController: leftSideNavController)
        let centerNav = UINavigationController(rootViewController: centerViewController)
        let rightNav = UINavigationController(rootViewController: rightSideNavController)
        
        self.drawerController = DrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav, rightDrawerViewController: rightNav)
        
        self.drawerController.showsShadows = true
        self.drawerController.restorationIdentifier = "Drawer"
        self.drawerController.openDrawerGestureModeMask = .All
        self.drawerController.closeDrawerGestureModeMask = .All
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window?.rootViewController = self.drawerController
        //self.window?.makeKeyAndVisible()
        
        if PFUser.currentUser() != nil {
           // navigationController.pushViewController(centerViewController, animated: false)
        } else {
          //  navigationController.pushViewController(loginViewController, animated: false)
        }
        
        self.window?.rootViewController = self.drawerController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func application(application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [AnyObject], coder: NSCoder) -> UIViewController? {
        print(identifierComponents)
        if let key = identifierComponents.last as? String {
            print(key)
        }
        
        return nil
    }

    
}

