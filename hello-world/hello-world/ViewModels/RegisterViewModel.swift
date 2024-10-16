//
//  RegisterViewModel.swift
//  hello-world
//
//  Created by Animesh on 16/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    @Published var first_name = ""
    @Published var last_name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func register() {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUser(id: userId)
        }
    }
    
    private func insertUser(id: String) {
        let newUser = User(id: id, name: first_name+" "+last_name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !first_name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "First name is required"
            return false
        }
        guard !last_name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Last name is required"
            return false
        }
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
        //Password Validations
        let uppercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let lowercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let specialCharacter = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")
        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters long"
            return false
        }
        guard uppercaseLetter.evaluate(with: password) else {
            print("Password must contain at least one uppercase letter")
            return false
        }
        guard lowercaseLetter.evaluate(with: password) else {
            print("Password must contain at least one lowercase letter")
            return false
        }
        guard specialCharacter.evaluate(with: password) else {
            print("Password must contain at least one special character")
            return false
        }
        return true
    }
}
