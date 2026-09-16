//
//  Constant.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/2/26.
//

enum Server: String {
    case movieEndPoint = "https://api.themoviedb.org/3/discover/movie?api_key=c91ed3a7a344459eccad9687acf0d07e"
}

enum Constant: String {
    case baseImageUrl = "https://image.tmdb.org/t/p/original"
    case movieCellIdentifier = "MovieTableViewCell"
    case movieHomeTitle = "Movies"
    case movieDetailsTitle = "Movie Details"
    case movieSearchPlaceholder = "Search movies..."
    case defaultImage = "photo.artframe"
}
