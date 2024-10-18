//
//  PropertyAPIManager.swift
//  RealEstateAR
//
//  Created by Leo Guo on 10/17/24.
//

import Foundation

// retrieve API key from Secrets.plist
func getAPIKey() -> String? {
    if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
       let xml = FileManager.default.contents(atPath: path) {
        let config = try? PropertyListDecoder().decode([String: String].self, from: xml)
        return config?["API_KEY"]
    }
    return nil
}

// handle HTTP GET requests
func makeApiCall(endpoint: String, apiKey: String, completion: @escaping (Result<Data, Error>) -> Void) {
    let baseUrl = "https://api.gateway.attomdata.com"
    guard let url = URL(string: baseUrl + endpoint) else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue(apiKey, forHTTPHeaderField: "apikey")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            print("No data received")
            return
        }

        completion(.success(data))
    }.resume()
}

// fetch property addresses
func fetchPropertyAddress(postalCode: String, page: Int, pageSize: Int, apiKey: String) {
    let endpoint = "/propertyapi/v1.0.0/property/address?postalcode=\(postalCode)&page=\(page)&pagesize=\(pageSize)"
    makeApiCall(endpoint: endpoint, apiKey: apiKey) { result in
        switch result {
        case .success(let data):
            if let responseString = String(data: data, encoding: .utf8) {
                print("Property Address Data: \(responseString)")
            }
        case .failure(let error):
            print("Error fetching property address: \(error)")
        }
    }
}

// fetch basic property profile
func fetchBasicProfile(address1: String, address2: String, apiKey: String) {
    let encodedAddress1 = address1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let encodedAddress2 = address2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let endpoint = "/propertyapi/v1.0.0/property/basicprofile?address1=\(encodedAddress1)&address2=\(encodedAddress2)"
    
    makeApiCall(endpoint: endpoint, apiKey: apiKey) { result in
        switch result {
        case .success(let data):
            if let responseString = String(data: data, encoding: .utf8) {
                print("Basic Property Profile Data: \(responseString)")
            }
        case .failure(let error):
            print("Error fetching basic property profile: \(error)")
        }
    }
}

// fetch property details with owner info
func fetchPropertyDetailOwner(attomid: String, apiKey: String) {
    let endpoint = "/propertyapi/v1.0.0/property/detailowner?attomid=\(attomid)"
    
    makeApiCall(endpoint: endpoint, apiKey: apiKey) { result in
        switch result {
        case .success(let data):
            if let responseString = String(data: data, encoding: .utf8) {
                print("Property Detail Owner Data: \(responseString)")
            }
        case .failure(let error):
            print("Error fetching property detail owner: \(error)")
        }
    }
}

// fetch detailed property information
func fetchPropertyDetails(attomid: String, apiKey: String) {
    let endpoint = "/propertyapi/v1.0.0/property/detail?attomid=\(attomid)"
    
    makeApiCall(endpoint: endpoint, apiKey: apiKey) { result in
        switch result {
        case .success(let data):
            if let responseString = String(data: data, encoding: .utf8) {
                print("Property Details Data: \(responseString)")
            }
        case .failure(let error):
            print("Error fetching property details: \(error)")
        }
    }
}

// Example usage -> in content view or other files

/*
if let apiKey = getAPIKey() {
    fetchPropertyAddress(postalCode: "93117", page: 1, pageSize: 100, apiKey: apiKey)
    fetchBasicProfile(address1: "6575 Trigo", address2: "Goleta, CA", apiKey: apiKey)
    fetchPropertyDetailOwner(attomid: "156379932", apiKey: apiKey)
    fetchPropertyDetails(attomid: "156379932", apiKey: apiKey)
} else {
    print("API key is missing or could not be retrieved.")
}
*/
