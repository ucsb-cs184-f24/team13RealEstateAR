import SwiftUI

struct ContentView: View {
    @State private var mapImage: UIImage? = nil

    var body: some View {
        VStack {
            if let image = mapImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ProgressView("Getting image...")
            }
        }
        .onAppear {
            getStaticMapImage(latitude: 34.418806, longitude: -119.861063, heading: 246.173050) { image in
                self.mapImage = image
                print("Map image fetched successfully")
            }
        }
    }

    func getStaticMapImage(latitude: Double, longitude: Double, heading: Double, completion: @escaping (UIImage?) -> Void) {
        let apiKey = "AIzaSyD-BaS2R7PIqBI_tHpa0Uc3AGxjcQnuESU"
        let urlString = "https://maps.googleapis.com/maps/api/streetview?size=600x400&location=\(latitude),\(longitude)&\(heading)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
