//
//  ArticleTableViewCell.swift
//  reader
//
//  Created by Krina on 10/11/24.
//

import UIKit
import Kingfisher
import FTLinearActivityIndicator

class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var activityIndicator: FTLinearActivityIndicator!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    // MARK: - Configuration
    private func configureView() {
        containerView.addDropShadow()
        selectionStyle = .none
    }
    
    func configure(with article: Articles) {
        dateLabel.text = article.publishedAt?.toString(format: "MMM dd, yyyy")
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        loadImage(from: article.urlToImage)
    }
    
    // MARK: - Image Loading
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            articleImageView.image = UIImage(named: "placeholder")
            return
        }

        activityIndicator.startAnimating()
        articleImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [.transition(.fade(0.2))],
            completionHandler: { [weak self] result in
                self?.activityIndicator.stopAnimating()
                switch result {
                case .success:
                    print("Image loaded successfully")
                case .failure(let error):
                    print("Image failed to load: \(error.localizedDescription)")
                }
            }
        )
    }
}
