//
//  WishlyApp.swift
//  Wishly
//
//  Created by Cristian Cruz on 9/18/26.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct WishlyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
