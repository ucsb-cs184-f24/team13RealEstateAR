import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var name = Auth.auth().currentUser?.displayName ?? "Guest"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hello,")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundColor(.indigo)
                    
                    Text(name)
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.leading)
                
                Button(action: {
                    PageView()
                }) {
                    Text("Button")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}



#Preview {
    HomeView()
}
