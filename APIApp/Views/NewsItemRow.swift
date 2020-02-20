//
//  NewsItemRow.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI
import URLImage


let defaluImageURl = "https://www.impigertech.com/sites/default/files/default_images/default-news-image_0.png"


struct NewsItemRow: View {
    var item: NewsArticleViewModel
    
    var body: some View {
        NavigationLink(destination: LazyView(NewsItemView(model: WebViewModel(link: self.item.webUrl ?? ""), item: self.item))) {
            
            NewsItemRowContent(item: self.item).cornerRadius(5).shadow(color: .black, radius: 5).padding(.trailing,12).padding(.leading, -8)
            
        }
    }
}


struct NewsItemRowContent: View {
    
    var item: NewsArticleViewModel
    let imageWidth: CGFloat = 120
    let imageHeight: CGFloat = 80

    var body: some View{
        
        
        VStack(alignment: .leading, spacing: 0){
            
            HStack(alignment: .top){
                
                URLImage(URL(string: self.item.urlToImage ?? defaluImageURl)!, placeholder: Image("defaultNewsImage")) { proxy in
                    proxy.image
                        .resizable()                     // Make image resizable
                        .frame(minWidth:self.imageWidth, maxWidth: self.imageWidth, minHeight: self.imageHeight, maxHeight: self.imageHeight)
                        .aspectRatio(contentMode: .fill) // Fill the frame
                        .clipShape(Rectangle())                      // Clip overlaping parts
                    
                }
                .frame(minWidth: self.imageWidth, maxWidth: self.imageWidth, minHeight: self.imageHeight, maxHeight: self.imageHeight)
                
                VStack (){
                    
                    Text("\(self.item.title)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Spacer(minLength:10)
                    
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 4){

                        Text("\(self.item.author)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.red)
                            .lineLimit(1)
                            Text("\(self.item.sourceNmae.uppercased())")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineLimit(1)
                        }
                        Spacer(minLength: 5)
                        VStack(alignment: .trailing, spacing: 4){
                            Text("\(self.item.publishedAtTime)")
                                    .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                    .lineLimit(1)
                            Text("\(self.item.publishedAtDate)")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineLimit(1)
                        }
                    }.padding(.trailing, 2)
                    
                }
                
            }.padding(.bottom, 8)
            
          //  VStack(alignment: .leading, spacing: 8) {
                
                Text("\(self.item.articleDescription)")
                    .font(.footnote)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            //}
            
        }.padding(.all, 4)
        .background(Color.white)
        .clipped()
        
    }
}


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
