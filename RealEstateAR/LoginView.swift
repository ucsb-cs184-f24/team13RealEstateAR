import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import Firebase

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
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Spacer()

                
                Button(action: signInWithGoogle) {
                    Text("Sign in with Google")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            guard error == nil else {
                print("Error during Google Sign-In: \(error!.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error: Failed to get user or token.")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            // Sign in to Firebase with the credential
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase Auth error: \(error.localizedDescription)")
                } else {
                    self.isAuthenticated = true
                    print("Signed in with Google successfully")
                }
            }
        }
    }

    func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
    }
}
