//
//  BusinessNews.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI
import URLImage

struct WorldNews: View {
    
    
    @ObservedObject var stockListViewModel = StockListViewModel()
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.red
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITableView.appearance().backgroundColor = UIColor.red
        UITableViewCell.appearance().backgroundColor = UIColor.white
        // https://stackoverflow.com/a/58426517/1571228 --> To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.clear
    }
    
    
    // context.coordinator.configureRefreshControl(for: tableViewController.tableView)
    var body: some View {
        NavigationView{
            
            PhotoGridScreen(stockListViewModel: stockListViewModel).onAppear(perform: fetch)
                
            .navigationBarTitle(Text("World News")
            .foregroundColor(Color.white))
        }.navigationViewStyle(StackNavigationViewStyle())

    }
    
    func getTopItem(index: Int) -> NewsArticleViewModel?{
        if index < self.stockListViewModel.topNews.count{
            let item: NewsArticleViewModel = self.stockListViewModel.topNews[index]
            return item
        }
        
        return nil
    }
    
    func getTopItemURL(index: Int) ->String{
        if let item = self.getTopItem(index: index){
            return item.webUrl!
        }
        return "https://newsapi.org"
    }
    
    func fetchTop(){
        stockListViewModel.loadTop()
    }
    
    func fetch(){
        stockListViewModel.load()
    }
    
}

struct WorldNewsListHeader: View {
    
    var body: some View {
        
        HStack() {
            Text("Category: News")
            Spacer()
            Text("Country: All World")
        }
            .padding(.all, 16)//
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.red)
            .padding(.trailing, 32)
    }
}

struct WorldNews_Previews: PreviewProvider {
    static var previews: some View {
        BusinessNews()
    }
}
