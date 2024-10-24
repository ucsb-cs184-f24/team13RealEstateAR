
import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String = ""
    @AppStorage("uname") var userName: String = ""
    
    var body: some View {
        NavigationView {
            if userID == "" {
                AuthView()
            } else {
                TabView {
                    HomeView(userID: $userID, userName: $userName)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "flag.pattern.checkered.circle")
                            Text("Dashboard")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                }
                .navigationTitle("Navigation")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeView: View {
    @Binding var userID: String
    @Binding var userName: String
    
    var body: some View {
        VStack {
            Text("Logged In! \nYour user id is \(userID) \nYour email is \(Auth.auth().currentUser?.email ?? "") \nYour name is \(Auth.auth().currentUser?.displayName ?? "")")
                .padding()
            
            Button(action: {
                signOut()
            }) {
                Text("Sign Out")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
    }
    
    private func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withAnimation {
                userID = "" // This will update the @AppStorage("uid")
                userName = "" // Clear the user name as well
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Dashboard Page")
            .font(.largeTitle)
            .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Page")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
