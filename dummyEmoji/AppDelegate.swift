//
//  AppDelegate.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 29/12/2017.
//  Copyright © 2017 Elliot Winch. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Firebase configurations
        FirebaseApp.configure()
        
        let uiStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var navigationController = UINavigationController(rootViewController: uiStoryboard.instantiateViewController(withIdentifier: "0"))
        window?.rootViewController = navigationController
        
        
        Auth.auth().addStateDidChangeListener { auth,user in
            if user != nil {
                print("Signed in")
                navigationController = UINavigationController(rootViewController: uiStoryboard.instantiateViewController(withIdentifier: "100"))
                self.window?.rootViewController = navigationController
                
                //Database management - User is added into the database if they are not there already
                print(user!.uid)
                
                let userDataPath = Database.database().reference().child("users")
                
                userDataPath.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                   if snapshot.hasChild(user!.uid) == false{
                        userDataPath.setValue(user!.uid)
                        
                        let specificUserPath = userDataPath.child(user!.uid)
                        
                        let userData = ["username" : user!.displayName,
                                        "email": user!.email]
                        
                        specificUserPath.updateChildValues(userData)
                    
                        let initChildren = ["favColor" : "0,0,0",
                                        "friends" : 0] as [String : Any]
                    
                        specificUserPath.updateChildValues(initChildren)
                        
                        specificUserPath.child("favColor").updateChildValues(["r" : 0, "g": 0, "b": 0])

                    }
                    
                })
                
                
            } else {
                print("Signed out")

                navigationController = SignInNavController(rootViewController: uiStoryboard.instantiateViewController(withIdentifier: "0"))
                self.window?.rootViewController = navigationController

            }
        }
        
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


}

