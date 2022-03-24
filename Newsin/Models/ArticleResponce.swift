//
//  Article.swift
//  Deccannews
//
//  Created by uday on 18/03/2022.
//
import Foundation

struct ArticleResponce: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImge: String?
}
