//  Created by LeoGuo on 10/21/24.
//
import GoogleSignIn
import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}


@main
struct RealEstateARApp: App {
    init() {
        FirebaseApp.configure()
    }
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
