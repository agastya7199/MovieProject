//
//  Movie.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/2/26.
//

// MARK: - Movie Model

struct Movie: Decodable {
    let page: Int
    var results: [Result]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result Model

struct Result: Decodable {
    let id: Int
    let title: String
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
