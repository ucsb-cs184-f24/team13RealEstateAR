//
//  LoginViewModel.swift
//  hello-world
//
//  Created by Animesh on 15/10/24.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Email Address is required"
            return false
        }
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Password is required"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email address"
            return false
        }
        return true
    }
}
