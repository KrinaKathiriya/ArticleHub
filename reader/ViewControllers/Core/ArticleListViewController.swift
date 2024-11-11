//
//  ViewController.swift
//  reader
//
//  Created by Krina on 10/11/24.
//

import UIKit
import FTLinearActivityIndicator
import Loaf
import Lottie

class ArticleListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataAnimationView: LottieAnimationView!
    @IBOutlet weak var activityIndicator: FTLinearActivityIndicator!
    
    // MARK: - Properties
    private let cacheManager = CacheManager()
    private let reachabilityManager = ReachabilityManager()
    private var searchButton: UIButton?
    
    private var articles: [Articles] = []
    private var filteredArticles: [Articles] = [] {
        didSet {
            noDataAnimationView.isHidden = !filteredArticles.isEmpty
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadCachedOrFetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Setup Methods
    private func setupView() {
        title = "Articles"
        setupSearchButton()
        setupNoDataAnimation()
        setupNavigationBar()
    }
    
    private func setupNoDataAnimation() {
        noDataAnimationView.loopMode = .loop
        noDataAnimationView.play()
    }
    
    private func setupSearchButton() {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(toggleSearchBar), for: .touchUpInside)
        
        navigationController?.navigationBar.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: navigationController!.navigationBar.rightAnchor, constant: -14),
            button.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        searchButton = button
    }
    
    // MARK: - Data Loading
    private func loadCachedOrFetchArticles() {
        if let cachedArticles = cacheManager.loadArticles() {
            articles = cachedArticles
            filteredArticles = cachedArticles
            articlesTableView.reloadData()
        } else if reachabilityManager.isConnected {
            fetchArticles()
        } else {
            showNoInternetConnection()
        }
    }
    
    private func fetchArticles() {
        startLoadingAnimation()
        ArticleService.fetchArticles { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingAnimation()
            
            switch result {
            case .success(let articleResponse):
                let cleanArticles = self.cleanArticles(from: articleResponse)
                self.handleSuccessfulArticleFetch(cleanArticles)
            case .failure:
                Loaf("Failed to load articles", state: .error, sender: self).show()
            }
        }
    }
    
    func cleanArticles(from response: ArticleResponse) -> [Articles] {
        if let articles = response.articles {
            return articles.filter { article in
                // Check if the article content or title is not empty or marked as [Removed]
                let isValidTitle = !(article.title?.isEmpty ?? true) && article.title != "[Removed]"
                let isValidContent = !(article.content?.isEmpty ?? true) && article.content != "[Removed]"
                let isValidDescription = article.description != "[Removed]"

                // Only include valid articles
                return isValidTitle && isValidContent && isValidDescription
            }
        }else{
            return []
        }
        
    }
    
    private func handleSuccessfulArticleFetch(_ articles: [Articles]) {
        Loaf("Articles Fetched!", state: .success, sender: self).show()
        self.articles = articles
        cacheManager.saveArticles(articles)
        filteredArticles = articles
        articlesTableView.reloadData()
    }
    // MARK: - Loading Animation
    private func startLoadingAnimation() {
        activityIndicator.startAnimating()
        stackView.isHidden = true
    }
    
    private func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
        stackView.isHidden = false
    }
    
    // MARK: - No Internet Handling
    private func showNoInternetConnection() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "NoInternetViewController") as? NoInternetViewController {
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            controller.delegate = self
            present(controller, animated: true)
        }
    }
    
    // MARK: - Actions
    @objc private func toggleSearchBar() {
        UIView.animate(withDuration: 0.3) {
            self.searchBar.isHidden.toggle()
        }
        
        if searchBar.isHidden {
            searchBar.text = ""
            filteredArticles = articles
            articlesTableView.reloadData()
        }
    }
    
}

// MARK: - TableView DataSource and Delegate
extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        let article = filteredArticles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController") as? ArticleDetailViewController
        detailVC?.selectedArticle = filteredArticles[indexPath.row]
        navigationController?.pushViewController(detailVC!, animated: true)
    }
}

// MARK: - NoInternetViewControllerDelegate
extension ArticleListViewController: NoInternetViewControllerDelegate {
    func noInternetViewControllerDidTapRetry() {
        fetchArticles()
    }
}

// MARK: - Search Bar Delegate
extension ArticleListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArticles(for: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterArticles(for: "")
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
    }

    private func filterArticles(for searchText: String) {
        if searchText.isEmpty {
            filteredArticles = articles
        } else {
            filteredArticles = articles.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        articlesTableView.reloadData()
    }
}
