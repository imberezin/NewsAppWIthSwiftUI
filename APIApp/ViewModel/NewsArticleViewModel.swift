//
//  NewsArticleViewModel.swift
//  APIApp
//
//  Created by Israel Berezin on 2/18/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import Foundation

struct NewsArticleViewModel: Identifiable {
    
    let id = UUID()
    
    let article: Article
    
    var urlToImage: String? {
        return self.article.urlToImage
    }
    
    var title: String {
        return self.article.title ?? ""
    }
    
    var publishedAtDate: String {
        
        if self.article.publishedAt != nil{
            let queryArray = article.publishedAt!.components(separatedBy: "T")
            return queryArray.first!
        }
        return self.article.publishedAt ?? ""
    }
    var publishedAtTime: String {
        if self.article.publishedAt != nil{
            let queryArray = article.publishedAt!.components(separatedBy: "T")
            let time: String = queryArray.last!
            return String(time.dropLast())
        }
        return self.article.publishedAt ?? ""
    }

    var sourceNmae: String {
        return self.article.source?.name ?? ""
    }
    var articleDescription: String {
        return self.article.description ?? ""
    }
    var content: String {
        return self.article.content ?? ""
    }

    var author: String {
        return self.article.author ?? ""
    }

    var webUrl: String? {
        return self.article.url
    }

}

/*
 {
 -"source": {
    "id": "cnbc",
    "name": "CNBC"
 },
 "author": "Arjun Kharpal",
 "title": "Apple shares slide after coronavirus guidance warning as its global suppliers are hammered - CNBC",
 "description": "Apple said it does not expect to meet its own guidance for the March quarter saying there was \"a slower return to normal conditions\" than it had anticipated. The warning sent Apple shares and those of its suppliers lower.",
 "url": "https://www.cnbc.com/2020/02/18/apple-shares-slide-after-coronavirus-revenue-guidance-warning.html",
 "urlToImage": "https://image.cnbcfm.com/api/v1/image/106395691-1582030949542gettyimages-1201582666.jpeg?v=1582030989",
 "publishedAt": "2020-02-18T11:37:00Z",
 "content": "Apple shares fell over 3% in pre-market trade on Tuesday after it warned that it does not expect to meet its own guidance for the March quarter because of the impact from the coronavirus.\r\nThe outbreak of the virus, which has killed over 1,800 people, also le… [+2623 chars]"
 },
 */
 
