//
//  AppDelegate.swift
//  Signals03
//
//  Created by SonGoku on 27/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //create 1 window chua toan bo cac view controllers
        window = UIWindow()
        window?.makeKeyAndVisible()
        
//        let layout = UICollectionViewFlowLayout()
//        let swpiepagesController = TestSwipePages(collectionViewLayout: layout)
        
        let randomViewController = UIViewController()
        randomViewController.view.backgroundColor = .blue
        
        window?.rootViewController = randomViewController
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

