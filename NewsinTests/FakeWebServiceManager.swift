//
//  MockWebServiceManager.swift
//  NewsinTests
//
//  Created by uday on 24/03/22.
//

import Foundation
@testable import Newsin

class FakeWebServiceManager: Service {
    
    var baseUrl: String = ""

    func getArticles<T>(path: String, params: [String : String], type: T.Type, completionHandler: @escaping (Result<T, ServiceError>) -> ()) where T : Decodable {
        
        let bundle = Bundle(for:FakeWebServiceManager.self)
        
        guard let url = bundle.url(forResource:path, withExtension:"json"),
              let data = try? Data(contentsOf: url)
        else {
            completionHandler(.failure(ServiceError.dataNotFound))
            return
        }
        
        do {
            let decodedResonce = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(decodedResonce))
        }catch {
            completionHandler(.failure(ServiceError.parsingError))
        }
    }
    
    
}
