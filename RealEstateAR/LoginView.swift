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
            VStack(spacing: 50) {
                VStack{
                    Text("AR RealEstate Assistant")
                        .font(.largeTitle)
                    HStack{
                        Text("Sign in with ")
                        Button(action: signInWithGoogle) {
                            Image("google")
                                .resizable()
                                .frame(width: 50, height: 50) 
                        }
                    }
                }
                Image(systemName: "building")
                    .resizable()
                    .frame(width: 80, height: 120)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign-in flow using the root view controller.
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
                    print("User Signed successfully with their google account")
                }
            }
        }
    }




    func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
    }
}
