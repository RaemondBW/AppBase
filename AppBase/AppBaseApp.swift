//
//  AppBaseApp.swift
//  AppBase
//
//  Created by Raemond Bergstrom-Wood on 12/29/23.
//

import SwiftUI
import Firebase

@main
struct AppBaseApp: App {
    @StateObject var appState = AppState() // Initialize your app state

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState) // Pass the AppState to your ContentView
        }
    }
}
