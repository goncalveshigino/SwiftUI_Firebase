//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by Goncalves Higino on 20/09/23.
//

import SwiftUI
import Firebase

@main
struct SwiftUIFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
