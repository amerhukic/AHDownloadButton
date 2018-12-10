//
//  AppDelegate.swift
//  AHDownloadButton
//
//  Created by Amer Hukić on 09/09/2018.
//  Copyright (c) 2018 Amer Hukić. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = DownloadViewController()
        return true
    }

}
