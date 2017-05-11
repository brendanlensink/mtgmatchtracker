//
//  AppDelegate.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let newMatch = UINavigationController(rootViewController: MatchViewController(match: nil))
        newMatch.tabBarItem = UITabBarItem(
            title: "Log A Match",
            image: UIImage(named: "tab_new"),
            tag:  1
        )
        
        let matchHistory = UINavigationController(rootViewController: MatchViewController(match: nil))
        matchHistory.tabBarItem = UITabBarItem(
            title: "View Past Matches",
            image: UIImage(named: "tab_history"),
            tag: 2
        )
        
        let tabViews = [
            newMatch,
            matchHistory
        ]
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor.white
        tabBar.viewControllers = tabViews
        
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

