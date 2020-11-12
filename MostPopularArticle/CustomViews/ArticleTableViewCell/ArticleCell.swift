//
//  ArticleCell.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import UIKit

class ArticleCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // Static Var
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - Custom Method
    func configureCell(articleViewModel: ArticleViewModel?) {
        guard let viewModel = articleViewModel else {
            return
        }
        print(viewModel.thumbnailUrlString ?? "kjdflajsldfjasljfdl")
        print(viewModel.imageUrlString ?? "dfajsfjlkdsajlfjdl")
        articleImageView.sd_setImage(with: URL(string: viewModel.thumbnailUrlString ?? ""), placeholderImage: nil)
        articleTitleLabel.text = viewModel.title
        publisherLabel.text = viewModel.byline
        dateLabel.attributedText = viewModel.publishedDate.addImageToString(imageName: "calender.png")
    }
}
