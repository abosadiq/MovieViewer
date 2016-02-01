//
//  AppDelegate.swift
//  MovieViewer
//
//  Created by Wafi MoHamed on 1/8/16.
//  Copyright © 2016 wafi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
   
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoivesNavigationContoroll") as! UINavigationController
        let nowPlayingViewCotroller = nowPlayingNavigationController.topViewController as! MovieViewController
        nowPlayingViewCotroller.endpoint = "now_playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "now_playing")
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        
        let topRatedNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoivesNavigationContoroll") as! UINavigationController
        let topRatedViewCotroller = topRatedNavigationController.topViewController as! MovieViewController
       topRatedViewCotroller.endpoint = "top_rated"
       topRatedNavigationController.tabBarItem.image = UIImage(named: "top_rated")
        
        topRatedNavigationController.tabBarItem.title = "Top Rated"
    

        
        let tapBar = UITabBarController()
        let popularNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoivesNavigationContoroll") as! UINavigationController
        let popularViewCotroller = popularNavigationController.topViewController as! MovieViewController
       popularViewCotroller.endpoint = "popular"
       popularNavigationController.tabBarItem.image = UIImage(named: "popular")
       popularNavigationController.tabBarItem.title = "Popular"
        
      
        let upComingNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoivesNavigationContoroll") as! UINavigationController
        let upComingViewCotroller = upComingNavigationController.topViewController as! MovieViewController
        upComingViewCotroller.endpoint = "upcoming"
        upComingNavigationController.tabBarItem.image = UIImage(named: "up_coming")
        upComingNavigationController.tabBarItem.title = "Up Coming"
         //upComingNavigationController.view.backgroundColor = UIColor.redColor()
        
//        let latestNavigationController = storyboard.instantiateViewControllerWithIdentifier("MoivesNavigationContoroll") as! UINavigationController
//        let latestViewCotroller = latestNavigationController.topViewController as! MovieViewController
//        latestViewCotroller.endpoint = "latest"
//        latestNavigationController.tabBarItem.image = UIImage(named: "Latest")
//        latestNavigationController.tabBarItem.title = "Latest"
//
        
        tapBar.viewControllers = [nowPlayingNavigationController,topRatedNavigationController,popularNavigationController,upComingNavigationController]
        tapBar.tabBar.tintColor = UIColor.whiteColor()
        tapBar.tabBar.barTintColor =  UIColor(
            red: 0.1,
            green: 28/155.0,
            blue: 4,
            alpha: 1.0)
    

        
        window?.rootViewController = tapBar
        window?.makeKeyAndVisible()
        
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

