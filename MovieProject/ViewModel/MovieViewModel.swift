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
    func fetchMovies(completed: @escaping () -> ())
    func fetchTotalMoviesCount() -> Int
    func fetchMovie(index: Int) -> Result?
    func searchMoviesByTitle(with givenText: String, completionHandler: () -> ())
}

class MovieViewModel: MovieViewModelProtocol {
    
    // MARK: - Property
    
    var moviesList: Movie?
    var filteredMovies: [Result] = []
    let objNetworkManager: NetworkManagerProtocol
    
    // MARK: - Using DI ( Dependency Injection ) to avoid Memory Leak
    
    init(objNetworkManager: NetworkManagerProtocol) {
        self.objNetworkManager = objNetworkManager
    }
}

// MARK: - Fetching Movies API call

extension MovieViewModel {
    func fetchMovies(completed: @escaping () -> ()) {
        objNetworkManager.fetchMoviesFrom(serverUrl: Server.movieEndPoint.rawValue, completionHandler: { [weak self] fetchedMovies in
            self?.moviesList = fetchedMovies
            self?.filteredMovies = fetchedMovies?.results ?? []
            completed()
        })
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
