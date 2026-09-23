//
//  MovieViewModel.swift
//  MovieProject
//
//  Created by Mouli Agastya on 9/15/26.
//

import Foundation

// MARK: - Movie View Model Protocol

protocol MovieViewModelProtocol {
    var moviesList: Movie? { get set }
    var filteredMovies: [Result] { get set }
    // func fetchMovies(completed: @escaping () -> ())
    func fetchMovies() async
    func fetchTotalMoviesCount() -> Int
    func fetchMovie(index: Int) -> Result?
    func searchMoviesByTitle(with givenText: String, completionHandler: () -> ())
    var errorMessage: String? { get set }
}

class MovieViewModel: MovieViewModelProtocol {
    
    // MARK: - Property
    
    var moviesList: Movie?
    var filteredMovies: [Result] = []
    let objNetworkManager: NetworkManagerProtocol
    var errorMessage: String?
    
    // MARK: - Using DI ( Dependency Injection ) to avoid Memory Leak
    
    init(objNetworkManager: NetworkManagerProtocol) {
        self.objNetworkManager = objNetworkManager
    }
}

// MARK: - Fetching Movies API call

extension MovieViewModel {
    
    // MARK: - Fetching Movies with Network Manager and passing it to VC (Using Dispatch queue)
    
//    func fetchMovies(completed: @escaping () -> ()) {
//        objNetworkManager.fetchMoviesFrom(serverUrl: Server.movieEndPoint.rawValue, completionHandler: { [weak self] fetchedMovies in
//            self?.moviesList = fetchedMovies
//            self?.filteredMovies = fetchedMovies?.results ?? []
//            completed()
//        })
//    }
    
    // MARK: - Fetching Movies with Network Manager and passing it to VC (Using Async Await)
    
    func fetchMovies() async {
        self.errorMessage = nil
        
        let resultState = await objNetworkManager.fetchMoviesFrom(serverUrl: Server.movieEndPoint.rawValue)
        switch resultState {
        case .loading:
            break
        case .success(let movieData):
            self.moviesList = movieData
            self.filteredMovies = movieData.results
        case .failure(let error):
            self.moviesList = nil
            self.filteredMovies = []
            self.errorMessage = error.rawValue
        }
    }
}

// MARK: - Movie Helper Methods

extension MovieViewModel {
    func fetchTotalMoviesCount() -> Int {
        filteredMovies.count
    }
    
    func fetchMovie(index: Int) -> Result? {
        filteredMovies[index]
    }
    
    func searchMoviesByTitle(with givenText: String, completionHandler: () -> ()) {
        if givenText.isEmpty {
            filteredMovies = moviesList?.results ?? []
        } else {
            filteredMovies = moviesList?.results.filter { movie in
                movie.title.localizedCaseInsensitiveContains(givenText)
            } ?? []
        }
        completionHandler()
    }
}
