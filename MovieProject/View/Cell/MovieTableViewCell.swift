//
//  MovieTableViewCell.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/3/26.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier: String = Constant.movieCellIdentifier.rawValue
    
    // MARK: - Movie Cell UI declaration
    
    let moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Movie Cell Initializer methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(coder:) has not been implemented")
    }
    
    // MARK: - Setting up Cell UI
    
    func setUpUI() {
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieTitle)
        contentView.addSubview(releaseDate)
        setUpConstraints()
    }
    
    // MARK: - Adding constraints to the cell
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            moviePoster.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            movieTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 20),
            
            releaseDate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 45),
            releaseDate.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 20),
            releaseDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            releaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

extension MovieTableViewCell {
    
    // MARK: - Loading cell data
    
    func loadMovieCellData(movie: Result?) {
        movieTitle.text = movie?.title
        releaseDate.text = movie?.releaseDate
        moviePoster.downloadImage(from: "\(Constant.baseImageUrl.rawValue)\(movie?.posterPath ?? "")")
    }
}
