//
//  NewsItemView.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI

struct NewsItemView: View {
    
    @ObservedObject var model:WebViewModel //= WebViewModel(link: "https://www.wikipedia.org/")
    let item: NewsArticleViewModel?
    
    
    var body: some View {
        GeometryReader { geometry in

            VStack {
                ZStack{
                    SwiftUIWebView(viewModel: self.model)
//                    if self.model.didFinishLoading == false{
//                        PulsingLoader()
//                    }
                }
            }
            .navigationBarTitle("\(self.webNavigationBarTitle())", displayMode: .inline)
        }
    }
    
    func webNavigationBarTitle() -> String {
        if item != nil{
            return item!.sourceNmae
        }
        return "Web Page"
    }

}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(model: WebViewModel(link: "https://www.wikipedia.org/"), item: NewsArticleViewModel(article: Article()))
    }
}
