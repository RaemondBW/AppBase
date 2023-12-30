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

// TutorialView which shows some introductory content
struct TutorialView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Welcome to the Tutorial")
            // Add your tutorial content here
            Button("Finish Tutorial") {
                appState.hasCompletedTutorial = true
            }
        }
    }
}

// LoginView for handling user login
struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var username: String = ""
    @State private var password: String = ""
    
    func loginUser() {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription) // Handle errors appropriately in your real app
            } else {
                // Successfully logged in
                self.appState.isAuthenticated = true
            }
        }
    }

    var body: some View {
        VStack {
            Text("Login").font(.largeTitle)

            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                loginUser()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("Need an account? Register") {
                appState.isRegistering = true
            }
            .padding()
        }
        .padding()
    }
}

// RegistrationView for handling user registration
struct RegistrationView: View {
    @EnvironmentObject var appState: AppState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    func registerUser() {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription) // Handle errors appropriately in your real app
                    print(error)
                } else {
                    // Successfully registered
                    self.appState.isAuthenticated = true
                }
            }
        } else {
            print("Passwords do not match!") // Provide user feedback accordingly
        }
    }

    var body: some View {
        VStack {
            Text("Register").font(.largeTitle)

            TextField("Email", text: $username)
                .textInputAutocapitalization(.never)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Register") {
                // Handle registration logic here
                // Ensure passwords match and other validations before setting isAuthenticated
                if password == confirmPassword {
                    registerUser()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("Already have an account? Login") {
                appState.isRegistering = false
            }
            .padding()
        }
        .padding()
    }
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
    @StateObject var appState = AppState()

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
