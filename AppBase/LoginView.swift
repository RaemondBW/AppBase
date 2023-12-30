//
//  LoginView.swift
//  AppBase
//
//  Created by Raemond Bergstrom-Wood on 12/29/23.
//

import SwiftUI
import FirebaseAuth // If using Firebase

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

            TextField("Email", text: $username)
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

// Preview for SwiftUI Canvas
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState())
    }
}
