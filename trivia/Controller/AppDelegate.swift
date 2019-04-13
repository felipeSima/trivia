//
//  AppDelegate.swift
//  trivia
//
//  Created by Felipe Silva Lima on 3/28/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        return true
        
    }
    
}

