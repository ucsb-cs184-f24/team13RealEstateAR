import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @State private var isAuthenticated = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        if isAuthenticated {
            HomeView()
        } else {
            VStack(spacing: 50) {
                Button(action: googleSignIn) {
                    HStack {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                        
                        Text("Sign in with Google")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    
    func googleSignIn() {
        // Ensure the Firebase client ID is available
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Error: Firebase client ID not found.")
            return
        }

        // Configure Google Sign-In with client ID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the Google Sign-In flow using the root view controller
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }

            // Ensure we have a valid user and ID token
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error: Failed to get user or ID token.")
                return
            }

            // Access token is already non-optional, so no need for guard let
            let accessToken = user.accessToken.tokenString

            // Create a Firebase credential from Google ID and access tokens
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            // Sign in to Firebase with the credential
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Auth error: \(error.localizedDescription)")
                    return
                }

                // Update authentication state
                self.isAuthenticated = true
                print("Signed in with Google successfully.")
            }
        }
    }



    func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                return UIViewController()
        }
        return rootViewController
    }
}

#Preview {
    LoginView()
}
