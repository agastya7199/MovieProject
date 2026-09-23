//
//  MockMovieViewModel.swift
//  MovieProject
//
//  Created by Mouli Agastya on 9/15/26.
//

import Foundation

class MockMovieViewModel: MovieViewModelProtocol {
    
    // MARK: - Property Declaration
    
    var moviesList: Movie?
    var filteredMovies: [Result] = []
    var errorMessage: String?
    
    // MARK: - Fetching Mock data
    
//    func fetchMovies(completed: @escaping () -> ()) {
//        let movie = Movie(
//            page: 1,
//            results: [
//                Result(
//                    id: 1,
//                    title: "Spider-Man: Brand New Day",
//                    originalLanguage: "en",
//                    overview: "Fighting crime full-time as Spider-Man in a world that doesn't remember him—and the pressure of seeing his old friends move on without him—sparks a change in Peter Parker he may not have the power to control. But that transformation might also be the only thing that can stop a shocking new threat to the city and those he loves - a powerful villain no one can even see.",
//                    posterPath: "/bjiS5ipwxb9JFy3XRRN4OAilSeX.jpg",
//                    backdropPath: "/qeQJx07rK2xm8SD2sJxFKhE7gs0.jpg",
//                    voteAverage: 8.7,
//                    releaseDate: "2026-07-29"
//                ),
//                Result(
//                    id: 2,
//                    title: "The Odessey",
//                    originalLanguage: "en",
//                    overview: "Odysseus, the legendary King of Ithaca, embarks on a long and perilous journey home following the Trojan War. Throughout his voyage, he is forced to confront the whims of gods, mythological monsters, and trials that stretch both his cunning and his humanity to the breaking point.",
//                    posterPath: "/5rhTDKUhPYvpdQIijFIs5VoWsON.jpg",
//                    backdropPath: "/iuylzRSllrGn7YB322kwKoOVMcq.jpg",
//                    voteAverage: 7.6,
//                    releaseDate: "2026-07-15"
//                )
//            ],
//            totalPages: 1,
//            totalResults: 1
//        )
//        self.moviesList = movie
//        self.filteredMovies = movie.results
//        completed()
//    }
    
    func fetchMovies() async {
        let movie = Movie(
            page: 1,
            results: [
                Result(
                    id: 1,
                    title: "Spider-Man: Brand New Day",
                    originalLanguage: "en",
                    overview: "Fighting crime full-time as Spider-Man in a world that doesn't remember him—and the pressure of seeing his old friends move on without him—sparks a change in Peter Parker he may not have the power to control. But that transformation might also be the only thing that can stop a shocking new threat to the city and those he loves - a powerful villain no one can even see.",
                    posterPath: "/bjiS5ipwxb9JFy3XRRN4OAilSeX.jpg",
                    backdropPath: "/qeQJx07rK2xm8SD2sJxFKhE7gs0.jpg",
                    voteAverage: 8.7,
                    releaseDate: "2026-07-29"
                ),
                Result(
                    id: 2,
                    title: "The Odessey",
                    originalLanguage: "en",
                    overview: "Odysseus, the legendary King of Ithaca, embarks on a long and perilous journey home following the Trojan War. Throughout his voyage, he is forced to confront the whims of gods, mythological monsters, and trials that stretch both his cunning and his humanity to the breaking point.",
                    posterPath: "/5rhTDKUhPYvpdQIijFIs5VoWsON.jpg",
                    backdropPath: "/iuylzRSllrGn7YB322kwKoOVMcq.jpg",
                    voteAverage: 7.6,
                    releaseDate: "2026-07-15"
                )
            ],
            totalPages: 1,
            totalResults: 1
        )
        self.moviesList = movie
        self.filteredMovies = movie.results
    }
    
    // MARK: - Fetch Movies Helper Functions
    
    func fetchTotalMoviesCount() -> Int {
        filteredMovies.count
    }
    
    func fetchMovie(index: Int) -> Result? {
        guard let _ = moviesList, index < filteredMovies.count else { return nil }
        return filteredMovies[index]
    }
    
    func searchMoviesByTitle(with givenText: String, completionHandler: () -> ()) {
        if givenText.isEmpty {
            filteredMovies = moviesList?.results ?? []
        } else {
            filteredMovies = moviesList?.results.filter { movie in
                movie.title.lowercased().contains(givenText.lowercased())
            } ?? []
        }
        completionHandler()
    }
}
