//
//  PassResetViewModel.swift
//  hello-world
//
//  Created by Animesh on 21/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class PassResetViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func resetPassword(completion: @escaping (Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.alertMessage = "Error: \(error.localizedDescription)"
                self.showAlert = true
                completion(false)
            } else {
                self.alertMessage = "If an account exists for this email, a password reset email has been sent."
                self.showAlert = true
                completion(true)
            }
        }
    }
}

