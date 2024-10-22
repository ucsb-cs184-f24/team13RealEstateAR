//
//  ProfileView.swift
//  hello-world
//
//  Created by Animesh on 19/10/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            if let user = profileViewModel.user {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.gray)
                    .frame(width: 125, height: 125)
                    .offset(y: -100)
                
                InfoField(title: "Name", value: user.name, iconName: "person.fill")
                    .padding(.bottom, 15)
                InfoField(title: "Email", value: user.email, iconName: "envelope.fill")
                    .padding(.bottom, 15)
                InfoField(title: "Member Since", value: "\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))", iconName: "calendar")
                    .padding(.bottom, 15)
                
                Button(action: {
                    // Login action
                    profileViewModel.logout()
                }) {
                    Text("Log Out")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 50)
                }
            }
            else {
                Text("Loading profile....")
            }
        }
        .onAppear() {
            profileViewModel.fetchUser()
        }
    }
}

struct InfoField: View {
    var title: String
    var value: String
    var iconName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Icon on the left
                Image(systemName: iconName)
                    .foregroundColor(.gray)
                    .frame(width: 20)
                
                // Value text
                Text(value)
                    .font(.body)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                // Border around the rectangle
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .overlay(
                // Title on the outline of the rectangle
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .offset(x: 20,y: -8),
                alignment: .topLeading
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
