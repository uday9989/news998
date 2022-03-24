//
//  ArticleViewModel.swift
//  Deccannews
//
//  Created by uday on 18/03/2022.
//
import Foundation
import Combine

enum ArticleViewState {
    case none
    case loadingArticles
    case lodingCompleted([Article])
    case error(String)
}

class ArticleViewModel {
    
    let webService: Service
    private var cancellables:Set<AnyCancellable> = Set()
    @Published  var articleViewState: ArticleViewState = .none

    init (_ service: Service = Webservice(ServiceEndPoints.baseUrl)) {
        self.webService = service
    }
    
    func getArticles(path: String, params:[String:String]) {
        articleViewState = .loadingArticles
        
        webService.getArticles(path: path, params: params, type:ArticleResponce.self) { result in
            
            switch  result {
                
            case .success(let articleResopnce):
                self.articleViewState = .lodingCompleted(articleResopnce.articles)
            case .failure(_):
                self.articleViewState = .error(Constants.apiFailedMessage)
            }
        }
    }
}


