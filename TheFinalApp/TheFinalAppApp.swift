//
//  TheFinalAppApp.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
//    FirebaseApp.app()?.isDataCollectionDefaultEnabled = true
    return true
  }
}

@main
struct TheFinalAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
 
    var body: some Scene {
        WindowGroup {
//            RootView()
            WorkoutView()
        }
    }
}



