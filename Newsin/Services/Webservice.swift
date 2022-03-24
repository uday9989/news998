//
//  Webservice.swift
//  Deccannews
//
//  Created by uday on 18/03/2022.
//

import Foundation


protocol Service {
    var baseUrl: String {get}
    func getArticles<T:Decodable>(path:String, params: [String: String], type:T.Type, completionHandler: @escaping(Result<T, ServiceError>) -> ())
}

class Webservice: Service {
    
    let baseUrl: String
    
    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getArticles<T>(path: String, params: [String: String], type: T.Type, completionHandler: @escaping (Result<T, ServiceError>) -> ()) where T : Decodable {
        
        var urlComponents =   URLComponents(string: baseUrl.appending(path))
        
        let quertyItems =   params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        urlComponents?.queryItems = quertyItems
        
        
        guard let url = urlComponents?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            guard let data = data, error == nil else {
                completionHandler(.failure(ServiceError.dataNotFound))
                return
            }

            do {
                let decodedResonce = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedResonce))
            }catch {
                completionHandler(.failure(ServiceError.parsingError))
            }
            
        }.resume()
        
    }
    
}
