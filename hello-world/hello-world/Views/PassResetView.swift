//
//  PassResetView.swift
//  hello-world
//
//  Created by Animesh on 21/10/24.
//

import SwiftUI

struct PassResetView: View {
    
    @StateObject var passResetViewModel = PassResetViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 23/255, green: 50/255, blue: 87/255).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.white))
                .offset(y: 150)
            VStack {
                Image("AR_app_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .offset(y: -310)
            }
            VStack {
                Text("Reset Password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .offset(y: -90)
                
                // Email field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .bold()
                        .padding(.top, 20)
                    TextField("", text: $passResetViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }.padding(.horizontal)
                
                // Forgot Password button
                Button(action: {
                    // Forgot Password action
                    passResetViewModel.resetPassword() { success in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Forgot Password")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .alert(isPresented: $passResetViewModel.showAlert) {
                    Alert(title: Text("Reset Password"), message: Text(passResetViewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    PassResetView()
}
