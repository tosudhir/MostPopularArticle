//
//  ArticleDetailViewController.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import UIKit
import SDWebImage

class ArticleDetailViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    // iVar
    var articleViewModel: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArticleData()
    }
    
    private func setupArticleData() {
        articleImageView.sd_setImage(with: URL(string: articleViewModel.imageUrlString ?? ""), placeholderImage: nil)
        articleTitleLabel.text = articleViewModel.title
        publisherLabel.text = articleViewModel.byline
        dateLabel.text = articleViewModel.publishedDate
        abstractLabel.text = articleViewModel.abstract
    }
}
