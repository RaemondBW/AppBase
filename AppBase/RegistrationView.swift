//
//  RegistrationView.swift
//  AppBase
//
//  Created by Raemond Bergstrom-Wood on 12/29/23.
//

import SwiftUI
import FirebaseAuth // If using Firebase

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

// Preview for SwiftUI Canvas
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(AppState())
    }
}
