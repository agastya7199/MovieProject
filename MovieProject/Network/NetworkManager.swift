//
//  NetworkManager.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/1/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchMoviesFrom(serverUrl: String, completionHandler: @escaping (Movie?) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Fetching Movie from the API
    
    func fetchMoviesFrom(serverUrl: String, completionHandler: @escaping (Movie?) -> ()) {
        let session = URLSession.shared
        
        guard let serverUrl = URL(string: serverUrl) else {
            print("Log:: Invalid URL")
            completionHandler(nil)
            return
        }
        
        let request = URLRequest(url: serverUrl)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Log:: Error fetching the data", error)
                completionHandler(nil)
                return
            }
            
            guard let jsonData = data else {
                print("Log:: json data is nil, unable to convert to model")
                completionHandler(nil)
                return
            }
            
            do {
                // MARK: - Decoding the recieved JSON data to struct
                
                let moviesList = try JSONDecoder().decode(Movie?.self, from: jsonData)
                // print("Movies List:", moviesList)
                completionHandler(moviesList)
                return
            } catch {
                print("Log:: Unable to convert data to movie model")
                return
            }
        }.resume()
        completionHandler(nil)
        return
    }
}
