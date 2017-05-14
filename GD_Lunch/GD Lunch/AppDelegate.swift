//
//  AppDelegate.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/3/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = RouterVC(nibName: "RouterVC", bundle: nil)  //to demonstrate using the system's designated initializer directly
        //or we could have called SplashVC(nibNameInferredForBundle: nil), our custom convenience initializer.  In which we used dynamic typing to figure out the type's name.
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    //MARK: Configuration
    func configureAppearance() {
        //global styling of UI elements
        
        //nav bar
        UINavigationBar.appearance().tintColor = .white  //changes bar button text color
        UINavigationBar.appearance().barTintColor = Style.Color.darkMustard
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(0.0, for: .default) //move down ?px
        
        //tNOTE: both the backgroundImage and the shadow image must be set to remove the shadow
        let image = UIImage(color: Style.Color.darkMustard, size: CGSize(width: 1,height: 1))
        UINavigationBar.appearance().setBackgroundImage(image, for: .default)
        UINavigationBar.appearance().shadowImage = image
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightHeavy)]
        
        //bar button items
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 15.0)], for: .normal)
    }

}

