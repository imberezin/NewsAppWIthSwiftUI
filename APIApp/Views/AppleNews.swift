//
//  BusinessNews.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI
import URLImage

struct AppleNews: View {
    
    
    @ObservedObject var stockListViewModel = StockListViewModel()
    
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

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
    
    
    @ViewBuilder
    var body: some View {
        NavigationView{
            VStack{

                ScrollView(.horizontal){
                    HStack{
                        ForEach(0 ..< self.topItemNumbers()){ index in
                            NavigationLink(destination: LazyView(NewsItemView(model: WebViewModel(link: self.getTopItemURL(index: index)), item: self.getTopItem(index: index)))) {
                                HStack{
                                   if self.horizontalSizeClass == .compact {
                                    NewsTopItemCell(item:self.getTopItem(index: index))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .bottom, .leading], 8)

                                    } else {
                                        NewsTopItemCell(item:self.getTopItem(index: index), supportSizeClass: true)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding([.top, .bottom, .leading], 8)
                                        
                                        NewsTopItemCell(item:self.getTopItem(index: index + self.topItemNumbers()), supportSizeClass: true)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding([.top, .bottom, .leading], 8)

                                    }

//                                    NewsTopItemCell(item:self.getTopItem(index: index))
//                                        .fixedSize(horizontal: false, vertical: true)
//                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                        .padding([.top, .bottom, .leading], 8)
//                                    self.horizontalSizeClass == .regular{
//                                        NewsTopItemCell(item:self.getTopItem(index: index))
//                                            .fixedSize(horizontal: false, vertical: true)
//                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                            .padding([.top, .bottom, .leading], 8)
//
//                                    }
                                }
                                
                            }
                                .buttonStyle(PlainButtonStyle()) //Navigation Link Issue with SwiftUI --> https://forums.developer.apple.com/thread/119809
                        }
                    }
                }
                .frame(height: 220)
                .onAppear(perform: fetchTop)

                List {
                    Section(header:WorldNewsListHeader())
                    {
                        ForEach(self.stockListViewModel.news) { news in
                            NewsItemRow(item: news)
                        }
                    }
                }
                .padding(.top, -8)
                    .padding(.trailing, -32.0/*-32.0*/)  //workaround to hide NavigationLink Arrow -> https://stackoverflow.com/a/56586580/1571228
                    .onAppear(perform: fetch)
            }
                
            .navigationBarTitle(Text("News App")
            .foregroundColor(Color.white))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func topItemNumbers() -> Int{
//        if self.horizontalSizeClass == .compact{
//            return 5
//        }
//        return 10
        return 5

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

struct AppleNewsListHeader: View {
    
    var body: some View {
        
        HStack() {
            Text("Category: News")
            Spacer()
            Text("Country: Apple News")
        }
            .padding(.all, 16)//
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.red)
            .padding(.trailing, 32)
    }
}

struct AppleNews_Previews: PreviewProvider {
    static var previews: some View {
        BusinessNews()
    }
}
