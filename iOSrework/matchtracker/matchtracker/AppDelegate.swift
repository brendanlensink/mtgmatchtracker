//
//  AppDelegate.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-12.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let newMatch = UINavigationController(rootViewController: NewMatchViewController())
        newMatch.navigationBar.barTintColor = Color.TabBar.background
        newMatch.navigationBar.tintColor = Color.TabBar.text
        newMatch.tabBarItem = UITabBarItem(
            title: "Log A Match",
            image: UIImage(named: "new"),
            tag:  1
        )
        
        let matchHistory = UINavigationController(rootViewController: MatchHistoryViewController())
        matchHistory.navigationBar.barTintColor = Color.TabBar.background
        matchHistory.navigationBar.tintColor = Color.TabBar.text
        matchHistory.tabBarItem = UITabBarItem(
            title: "View Past Matches",
            image: UIImage(named: "history"),
            tag: 2
        )
        
        let tabViews = [
            NewMatchViewController(),
            MatchHistoryViewController()
        ]
        let tabBar = UITabBarController()
        tabBar.viewControllers = tabViews
        
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

