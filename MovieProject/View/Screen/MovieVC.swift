//
//  MovieVC.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/2/26.
//

import UIKit

class MovieVC: UIViewController {
    // MARK: - Properties
    
    let movieViewModel: MovieViewModelProtocol
    
    // MARK: - Using DI ( Dependency Injection ) to avoid Memory Leak
    
    init(movieViewModel: MovieViewModelProtocol) {
        self.movieViewModel = movieViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init? coder not defined")
    }
    
    // MARK: - Movie Table View declaration
    
    let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Movie Search Box
    
    let searchBox: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constant.movieSearchPlaceholder.rawValue
        searchBar.layer.cornerRadius = 10
        searchBar.widthAnchor.constraint(equalToConstant: 350).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - View Life cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.movieHomeTitle.rawValue
        self.view.backgroundColor = .systemBackground
        movieTableView.dataSource = self
        movieTableView.delegate = self
        searchBox.delegate = self
        setUpUI()
        fetchMovies()
    }
    
    // MARK: - Setting up the UI
    
    func setUpUI() {
        view.addSubview(searchBox)
        view.addSubview(movieTableView)
        setUpConstraints()
    }
    
    // MARK: - Setting up constraints
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            movieTableView.topAnchor.constraint(equalTo: searchBox.bottomAnchor, constant: 10),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Fetching Movies with view model and reloading table view
    
    func fetchMovies() {
        movieViewModel.fetchMovies(completed: {
            DispatchQueue.main.async { [weak self = self] in
                self?.movieTableView.reloadData()
            }
        })
    }
}

// MARK: - Table View Data Source Methods

extension MovieVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieViewModel.fetchTotalMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        cell?.selectionStyle = .none
        cell?.loadMovieCellData(movie: movieViewModel.fetchMovie(index: indexPath.row))
        return cell ?? UITableViewCell()
    }
}

// MARK: - Table View Delegate Methods

extension MovieVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objMovieDetail = MovieDetailsVC()
        objMovieDetail.loadMoviesData(movie: movieViewModel.fetchMovie(index: indexPath.row))
        navigationController?.pushViewController(objMovieDetail, animated: true)
    }
}

// MARK: - Search Bar Delegate Methods

extension MovieVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieViewModel.searchMoviesByTitle(with: searchText) { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
}
