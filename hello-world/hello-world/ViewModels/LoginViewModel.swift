//
//  LoginViewModel.swift
//  hello-world
//
//  Created by Animesh on 15/10/24.
//

import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func Glogin() async {
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("Unable to access root view controller.")
            return
        }

        do {
            let userAuth = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuth.user
            guard let idToken = user.idToken else {
                return
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            
            self.linkAccount(with: credential)
            
            //insert user data
            let db = Firestore.firestore()
            
            let dbUser: User
            
            let uid = result.user.uid
            let userRef = db.collection("users").document(uid)
            
            let document = try await userRef.getDocument()
            
            if document.exists {
                let dbData = document.data() ?? [:]
                let joined = dbData["joined"] as? TimeInterval ?? 0
                dbUser = User(id: result.user.uid,
                                name: result.user.displayName ?? "",
                                email: result.user.email ?? "",
                                joined: joined)
            } else {
                dbUser = User(id: result.user.uid,
                                name: result.user.displayName ?? "",
                                email: result.user.email ?? "",
                                joined: Date().timeIntervalSince1970)
            }
            try await db.collection("users")
                .document(uid)
                .setData(dbUser.asDictionary(), merge: true)
        } catch {
            print(error)
            
        }
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
    
    func linkAccount(with credential: AuthCredential) {
        guard let user = Auth.auth().currentUser else {
            print("No user is currently signed in.")
            return
        }

        user.link(with: credential) { authResult, error in
            if let error = error {
                // Handle error (e.g., if the credential is already linked to another account)
                if (error as NSError).code == AuthErrorCode.credentialAlreadyInUse.rawValue {
                    print("This credential is already linked to another account.")
                    // You can sign in with the new credential to resolve this
                    Auth.auth().signIn(with: credential) { authResult, error in
                        if let error = error {
                            print("Sign-in error: \(error.localizedDescription)")
                        } else {
                            print("User signed in with the new provider.")
                        }
                    }
                } else {
                    print("Error linking account: \(error.localizedDescription)")
                }
            } else {
                // Successfully linked the account
                print("Account linked successfully.")
            }
        }
    }
}
