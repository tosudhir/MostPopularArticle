//
//  ArticleViewController.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import UIKit

class ArticleViewController: UIViewController {
    
    // IBOutlet
    @IBOutlet weak var articleTableView: UITableView!

    // iVar
    var articleViewModels = [ArticleViewModel]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        self.title = Constants.articalControllerTitle
        setupTableView()
        fetchArticles()
    }
    
    private func setupTableView() {
        self.articleTableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.identifier)
    }
    
    private func moveToDetailScreen(viewModel: ArticleViewModel) {
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArticleDetailViewController") as? ArticleDetailViewController else {
            print("Not created")
            return
        }
        controller.articleViewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func fetchArticles() {
        //showLoadingIndicator()
        let manager = ApiManager()
        manager.fetchArticles(period: .day) { [weak self](articles) in
            self?.articleViewModels = articles.map{
                ArticleViewModel(article: $0)
            }
            self?.articleTableView.reloadData()
            //self.hideLodingIndicatore()
        } failure: { (message) in
            //self.hideLodingIndicatore()
            self.showAlert(title: "Error", message: message, actions: ["OK"], completion: nil)
        }

    }
}

//MARK: - TableView Datasource
extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier) as? ArticleCell {
            cell.configureCell(articleViewModel: articleViewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - TableView Delegate
extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        moveToDetailScreen(viewModel: articleViewModels[indexPath.row])
    }
}
