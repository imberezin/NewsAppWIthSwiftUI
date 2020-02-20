//
//  Webservice.swift
//  StocksAppSwiftUI
//
//  Created by Mohammad Azam on 1/6/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class Webservice {
    
    
    let APIkey = "8dac245893cc4b6b807bbd8e69b96461"
    
    
    
    func getTopNews(country: String, completion: @escaping ((News?) -> Void)){
        guard let url = URL(string: "http://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(self.APIkey)&pageSize=5") else {
                   fatalError("URL is not correct")
               }
        self.getApi(url: url, completion: completion)
    }
    
    
    func getTopBusinessNews(country: String, completion: @escaping ((News?) -> Void)){
        
        guard let url = URL(string: "http://newsapi.org/v2/top-headlines?country=\(country)&category=business&apiKey=\(self.APIkey)&pageSize=20") else {
                   fatalError("URL is not correct")
               }
        
        self.getApi(url: url, completion: completion)
    }


    func getApi(url: URL, completion: @escaping ((News?) -> Void)) {
        
            URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let articles = try? JSONDecoder().decode(News.self, from: data)
            
            DispatchQueue.main.async {
                completion(articles)
            }
            
            
        }.resume()
        
        
    }
    
//    func getStocks(completion: @escaping (([Stock]?) -> Void)) {
//
//        guard let url = URL(string: "https://silicon-rhinoceros.glitch.me/stocks") else {
//            fatalError("URL is not correct")
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            guard let data = data, error == nil else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            let stocks = try? JSONDecoder().decode([Stock].self, from: data)
//            DispatchQueue.main.async {
//                completion(stocks)
//            }
//
//        }.resume()
//
//    }
    
}
