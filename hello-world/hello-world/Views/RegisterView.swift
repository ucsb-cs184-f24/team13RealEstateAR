//
//  RegisterView.swift
//  hello-world
//
//  Created by Animesh on 15/10/24.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var registerViewModel = RegisterViewModel()
    
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
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                // First name field
                VStack(alignment: .leading, spacing: 8) {
                    Text("First Name")
                        .bold()
                    TextField("", text: $registerViewModel.first_name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }.padding(.horizontal)
                
                // Last name field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Name")
                        .bold()
                    TextField("", text: $registerViewModel.last_name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }.padding(.horizontal)
                
                // Email field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .bold()
                    TextField("", text: $registerViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }.padding(.horizontal)
                
                // Password field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .bold()
                    SecureField("", text: $registerViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding(.horizontal)
                
                // Register button
                Button(action: {
                    // Register action
                    registerViewModel.register()
                }) {
                    Text("Register")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
