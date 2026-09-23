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
    private let refreshControl = UIRefreshControl()
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.accessibilityLabel = "Loading..."
        return indicator
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
        setUpRefreshControl()
        getMoviesAndLoadTableView()
    }
    
    // MARK: - Setting up the UI
    
    func setUpUI() {
        view.addSubview(searchBox)
        view.addSubview(movieTableView)
        view.addSubview(activityIndicator)
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
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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

extension MovieVC {
    // MARK: - Fetching Movies with view model and reloading table view ( Using Dispatch Queue )
    
    //    func fetchMovies() {
    //        movieViewModel.fetchMovies {
    //            DispatchQueue.main.async { [weak self = self] in
    //                self?.movieTableView.reloadData()
    //            }
    //        }
    //    }
    
    // MARK: - Fetching Movies with view model and reloading table view( Using Async Await )
    
    @objc func getMoviesAndLoadTableView() {
        activityIndicator.startAnimating()
        movieTableView.isHidden = true
        
        Task { [weak self] in
            await self?.movieViewModel.fetchMovies()
            
            await MainActor.run {
                guard let self = self else { return }
                
                self.movieTableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
                self.movieTableView.isHidden = false
                
                if let errorMessage = self.movieViewModel.errorMessage {
                    self.showErrorAlert(message: errorMessage)
                }
            }
        }
    }
    
    func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(getMoviesAndLoadTableView), for: .valueChanged)
        movieTableView.refreshControl = refreshControl
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Optional: Add a Retry action
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.getMoviesAndLoadTableView()
        })
        
        present(alert, animated: true, completion: nil)
    }
}
