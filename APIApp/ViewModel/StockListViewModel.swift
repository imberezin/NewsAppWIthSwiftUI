//
//  StockListViewModel.swift
//  APIApp
//
//  Created by Israel Berezin on 2/18/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class StockListViewModel: ObservableObject {
        
    @Published var dragOffset: CGSize = CGSize(width: 0, height: 650)
    @Published var searchTerm: String = ""
    @Published var news: [NewsArticleViewModel] = [NewsArticleViewModel]()
    @Published var topNews: [NewsArticleViewModel] = [NewsArticleViewModel]()

    func load() {
        if self.news.count == 0 {
            fetchNews()
        }
    }
    func loadTop() {
        if self.topNews.count == 0{
            fetchTopNews()
        }
    }
    private func fetchNews() {
        
        Webservice().getTopBusinessNews(country: "us") { news in
            if let news = news {
                print(news)
                
                let articles = news.articles?.map({ articles in
                    NewsArticleViewModel(article: articles)
                })

                DispatchQueue.main.async {
                    
                    if let articles = articles{
                        print(articles.count)
                        self.news = articles
                    }
                    
                }
            }
        }
    }
    
    private func fetchTopNews() {
        
        Webservice().getTopNews(country: "us") { news in
            if let news = news {
                print(news)
                
                let articles = news.articles?.map({ articles in
                    NewsArticleViewModel(article: articles)
                })

                DispatchQueue.main.async {
                    
                    if let articles = articles{
                        print(articles.count)
                        self.topNews = articles
                    }
                    
                }
            }
        }
    }
}


