//
//  AppDelegate.swift
//  FamilyList
//
//  Created by Shom on 24.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .light
        
        let tabBarController = UITabBarController()
        
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        
        tabBarController.viewControllers = [infoNavigationController]
        
        self.window?.rootViewController = tabBarController
        
        return true
    }
    
    
    
    
}

