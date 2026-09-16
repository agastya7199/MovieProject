//
//  MovieDetailsVC.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/3/26.
//

import UIKit

class MovieDetailsVC: UIViewController {
    // MARK: - Movie Details UI declaration
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Life cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.movieDetailsTitle.rawValue
        self.view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    // MARK: - Setting up the movie details UI
    
    func setUpUI() {
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        view.addSubview(movieOverview)
        setUpConstraints()
    }
    
    // MARK: - Adding constraints to the movie details
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            movieOverview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieOverview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Loading movie details data
    
    func loadMoviesData(movie: Result?) {
        movieImage.downloadImage(from: "\(Constant.baseImageUrl.rawValue)\(movie?.backdropPath ?? "")")
        movieTitle.text = movie?.title
        movieOverview.text = movie?.overview
    }
}
