//
//  AppDelegate.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dataStack = CoreDataStack(modelName: "AccountsModel", storeType: .Persistent)
    let settingsProvider = AccountSettingsProvider()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let categoryStore = CategoryStore(dataSource: dataStack)
        let openingBalance = Money.zero() //TODO: load/retrieve opening balance...
        let account = Account(openingBalance: openingBalance, dataSource: dataStack)
        let formatter = AccountsFormatter(dateFormat: "dd MMMM yyyy")
        
        if let tabBar = self.window?.rootViewController as? UITabBarController {
            for child in tabBar.childViewControllers {
                if child is UINavigationController {
                    if let transactionController = child.childViewControllers.first as? TransactionViewController {
                        transactionController.account = account
                        transactionController.categoryStore = categoryStore
                        transactionController.formatter = formatter
                        transactionController.settingsProvider = settingsProvider
                    }
                    if let categoriesController = child.childViewControllers.first as? CategoriesViewController {
                        categoriesController.categoryStore = categoryStore
                    }
                } else if let split = child as? UISplitViewController {
                    if let masterNav = split.viewControllers.first as? UINavigationController,
                        reportOptionController = masterNav.childViewControllers.first as? ReportOptionsTableViewController,
                        detailNav = split.viewControllers.last as? UINavigationController,
                        reportListController = detailNav.childViewControllers.first as? ReportListTableViewController {
                        
                        reportOptionController.account = account
                        reportOptionController.categoryStore = categoryStore
                        reportOptionController.formatter = formatter
                        reportOptionController.settingsProvider = settingsProvider
                        reportListController.navigationItem.leftBarButtonItem = split.displayModeButtonItem()
                    }
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        settingsProvider.saveChanges()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

