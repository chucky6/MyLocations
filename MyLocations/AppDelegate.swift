//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Antonio Alves on 1/27/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import UIKit
import CoreData

let MyManagedObjectContextSaveDidFailNotification = "MyManagedObjectContextSaveDidFailNotification"
func fatalCoreDataError(_ error: ErrorProtocol) {
    print("*** Fatal CoreData error: \(error)")
    NotificationCenter.default().post(name: Notification.Name(rawValue: MyManagedObjectContextSaveDidFailNotification), object: nil)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        customizeAppearance()
        let tabBarController = window!.rootViewController as! UITabBarController
        if let tabBarViewControllers = tabBarController.viewControllers {
            let currentLocationViewController = tabBarViewControllers[0] as!  CurrentLocationViewController
            currentLocationViewController.managedObjectContext = managedObjectContext
            let navigationController = tabBarViewControllers[1] as! UINavigationController
            let locationsViewController = navigationController.viewControllers[0] as! LocationsTableViewController
            locationsViewController.managedObjectContext = managedObjectContext
            
            let mapViewcontroller = tabBarViewControllers[2] as! MapViewController
            mapViewcontroller.managedObjectContext = managedObjectContext
        }
        listenForFatalCoreDataNotifications()
        return true
    }
    
    func customizeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.black()
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white() ]
        UITabBar.appearance().barTintColor = UIColor.black()
        let tintColor = UIColor(red: 255/255.0, green: 238/255.0,
            blue: 136/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().tintColor = tintColor
    
    }
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        guard let modelURL = Bundle.main().urlForResource("DataModel", withExtension: "momd") else {
            fatalError("Could not find data model in the app bundle")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing model from \(modelURL)")
        }
        let urls = FileManager.default().urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
        let documentsDirectory = urls[0]
        let storeURL = try! documentsDirectory.appendingPathComponent("DataStore.sqlite")
        
        do {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        } catch {
            fatalError("Error adding persisten store at: \(storeURL): \(error)")
        }
    }()
    
    func listenForFatalCoreDataNotifications() {
        NotificationCenter.default().addObserver(forName: NSNotification.Name(rawValue: MyManagedObjectContextSaveDidFailNotification), object: nil, queue: OperationQueue.main()) { _ in
            let alert = UIAlertController(title: "Internal Error", message: "There was a fatal error in the app and it cannot continue.\n\n"
                + "Press OK to terminate the app. Sorry for the inconvenience.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
                let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "Fatal CoreDataError", userInfo: nil)
                exception.raise()
            })
            alert.addAction(action)
            self.viewControllerForShowingAlert().present(alert, animated: true, completion: nil)
        }
    }
    
    func viewControllerForShowingAlert() -> UIViewController {
        let rootViewController = self.window!.rootViewController!
        if let presentedViewController = rootViewController.presentedViewController {
            return presentedViewController
        } else {
            return rootViewController
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

