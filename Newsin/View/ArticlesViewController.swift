//
//  NewsListTableViewController.swift
//  Deccannews
//
//  Created by uday on 18/03/2022.
//
import Foundation
import UIKit
import Combine

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var articleViewModel = ArticleViewModel()
    private var bindings = Set<AnyCancellable>()
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindViewState()
        articleViewModel.getArticles(path:Path.topStories, params: ["country":"us", "apiKey":Constants.apiKey])
    }
    
    private func bindViewState() {
        
        let cancellable =
        articleViewModel.$articleViewState.dropFirst().sink { [weak self] state in
            
            switch state {
            case .loadingArticles :
                self?.articles = []
            case .lodingCompleted(let articles) :
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .none:
                self?.articles = []
            case .error(let error):
                print(error)
            }
        }
        self.bindings.insert(cancellable)
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        return cell
    }
}
