//
//  ContentView.swift
//  AppBase
//
//  Created by Raemond Bergstrom-Wood on 12/29/23.
//

import SwiftUI
import FirebaseAuth

// AppState to control the flow of the app
class AppState: ObservableObject {
    @Published var hasCompletedTutorial: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var isRegistering: Bool = false // Added to handle navigation between login and registration
}

// MainAppView which is the primary view of your app
struct MainAppView: View {
    var body: some View {
        Text("Welcome to the Main App!")
        // Build out your main app interface here
    }
}

// ContentView to control which view is displayed
struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            if !appState.hasCompletedTutorial {
                TutorialView().environmentObject(appState)
            } else if !appState.isAuthenticated {
                if appState.isRegistering {
                    RegistrationView().environmentObject(appState)
                } else {
                    LoginView().environmentObject(appState)
                }
            } else {
                MainAppView()
            }
        }
    }
}

#Preview {
    ContentView()
}
