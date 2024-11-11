//
//  ArticleDetailViewController.swift
//  reader
//
//  Created by Krina on 10/11/24.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updatedAgoLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageShadowView: UIView!
    
    // MARK: - Properties
    var selectedArticle: Articles?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.configureContent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - Setup Methods
    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.imageShadowView.addDropShadow()
    }
    
    private func configureContent() {
        guard let selectedArticle = selectedArticle else { return }
        
        titleLabel.text = selectedArticle.title
        descriptionLabel.text = selectedArticle.content
        updatedAgoLabel.text = selectedArticle.publishedAt?.timeAgo() ?? ""
        
        if let imageUrlString = selectedArticle.urlToImage, let imageUrl = URL(string: imageUrlString) {
            articleImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        }
        
        updateLikeButtonImage()
    }
    
    
    // MARK: - UI Update Methods
    private func updateLikeButtonImage() {
        let isLiked = UserDefaults.likedArticles.contains(selectedArticle?.url ?? "")
        let likeButtonImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        let likeButtonTintColor: UIColor = isLiked ? .red : .white
        
        likeButton.setImage(likeButtonImage, for: .normal)
        likeButton.tintColor = likeButtonTintColor
    }
    
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        toggleLikeStatus()
        updateLikeButtonImage()
    }
    
    // MARK: - Helper Methods
    private func toggleLikeStatus() {
        guard let articleUrl = selectedArticle?.url else { return }
        
        if let index = UserDefaults.likedArticles.firstIndex(of: articleUrl) {
            UserDefaults.likedArticles.remove(at: index)
        } else {
            UserDefaults.likedArticles.append(articleUrl)
        }
    }
    
}
