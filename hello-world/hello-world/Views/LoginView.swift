//
//  LoginView.swift
//  hello-world
//
//  Created by Animesh on 14/10/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @State var showTexts = false
    @State var loginView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 23/255, green: 50/255, blue: 87/255).ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.white))
                    .offset(y: loginView ? 200 : 1000)
                    .animation(.easeInOut(duration: 1), value: loginView)
                
                VStack {
                    Image("AR_app_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .offset(y: loginView ? -125 : 150)
                        .animation(.easeInOut(duration: 1), value: loginView)
                        .padding(.top, 150)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, -70)
                        .opacity(showTexts ? 1 : 0)
                        .animation(.easeInOut(duration: 0.75), value: showTexts)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if !loginViewModel.errorMessage.isEmpty {
                            Text(loginViewModel.errorMessage)
                                .foregroundStyle(Color.red)
                        }
                        // Email field
                        Text("Email")
                            .bold()
                        TextField("", text: $loginViewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                    
                        // Password field
                        Text("Password")
                            .bold()
                        SecureField("", text: $loginViewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    .opacity(showTexts ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75), value: showTexts)
                    
                    // Login button
                    Button(action: {
                        // Login action
                        loginViewModel.login()
                    }) {
                        Text("Login")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .opacity(showTexts ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75), value: showTexts)
                    
                    // Reset password button
                    NavigationLink("Forgot Password?", destination: PassResetView())
                        .opacity(showTexts ? 1 : 0)
                        .animation(.easeInOut(duration: 0.75), value: showTexts)
                    
                    HStack {
                        VStack { Divider() }
                        Text("or")
                        VStack { Divider() }
                    }
                    .opacity(showTexts ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75), value: showTexts)
                
                    //Google-OAuth button
                    Button(action: {
                        // Login action
                        Task {
                            await loginViewModel.Glogin()
                        }
                    }) {
                        Image("googleLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                    }
                    .clipShape(Circle())
                    .shadow(radius: 2)
                    .opacity(showTexts ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75), value: showTexts)
                    
                    Spacer()
                    
                    VStack {
                        Text("Don't have an account?")
                        NavigationLink("Sign Up", destination: RegisterView())
                    }
                    .padding(.bottom, 50)
                    .opacity(showTexts ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75), value: showTexts)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.15){
                        loginView = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.15){
                        showTexts = true
                    }
                    
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
