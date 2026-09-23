//
//  NetworkManager.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/1/26.
//

import Foundation

enum APIState <T> {
    case loading
    case success(T)
    case failure(APIError)
}

enum APIError: String {
    case incorrectURL = "Unable to retrieve the data, Please try again!"
    case serverDown = "Server is down, Please try again!"
    case unableToParse = "Unable to convert retrieved data"
}

protocol NetworkManagerProtocol {
    // func fetchMoviesFrom(serverUrl: String, completionHandler: @escaping (Movie?) -> ())
    func fetchMoviesFrom(serverUrl: String) async -> APIState<Movie>
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - Fetching Movies from the Server and passing it to View Model (Using URL Session + Dispatch Queue)
    
//    func fetchMoviesFrom(serverUrl: String, completionHandler: @escaping (Movie?) -> ()) {
//        let session = URLSession.shared
//        
//        guard let serverUrl = URL(string: serverUrl) else {
//            print("Log:: Invalid URL")
//            completionHandler(nil)
//            return
//        }
//        
//        let request = URLRequest(url: serverUrl)
//        session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Log:: Error fetching the data", error)
//                completionHandler(nil)
//                return
//            }
//            
//            guard let jsonData = data else {
//                print("Log:: json data is nil, unable to convert to model")
//                completionHandler(nil)
//                return
//            }
//            
//            do {
//                // MARK: - Decoding the recieved JSON data to struct
//                
//                let moviesList = try JSONDecoder().decode(Movie?.self, from: jsonData)
//                // print("Movies List:", moviesList)
//                completionHandler(moviesList)
//                return
//            } catch {
//                print("Log:: Unable to convert data to movie model")
//                return
//            }
//        }.resume()
//        completionHandler(nil)
//        return
//    }
    
    // MARK: - Fetching Movies from the Server and passing it to View Model (Using URL Session + Async Await)
    
    func fetchMoviesFrom(serverUrl: String) async -> APIState<Movie> {
        guard let url = URL(string: serverUrl) else {
            return .failure(.incorrectURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.serverDown)
            }
            
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return .success(movie)
        } catch is DecodingError {
            return .failure(.unableToParse)
        }
        catch {
            return .failure(.serverDown)
        }
    }
}
