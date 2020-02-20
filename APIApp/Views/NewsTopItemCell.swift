//
//  NewsTopItemCell.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI
import URLImage

struct NewsTopItemCell: View {
    
    var item: NewsArticleViewModel?
    let imageWidth: CGFloat = UIScreen.main.bounds.width - 16
    let imageHeight: CGFloat = CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 < 200 ? CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 : 200.0
    
    
    /*
       NavigationLink(destination: LazyView(NewsItemView(model: WebViewModel(link: self.item!.urlToImage!), item: self.item))) {
     */
    @ViewBuilder // https://stackoverflow.com/a/57323368/1571228
    var body: some View {
        ZStack{
            Rectangle().fill(Color.white).frame(width:UIScreen.main.bounds.width - 16, height: 200)
            if item != nil{
              

                URLImage(URL(string: self.item?.urlToImage ?? defaluImageURl)!, placeholder: Image("defaultNewsImage")) { proxy in
                    proxy.image
                        .resizable()                     // Make image resizable
                        .frame(minWidth:self.imageWidth, maxWidth: self.imageWidth, minHeight: self.imageHeight, maxHeight: self.imageHeight)
                        .aspectRatio(contentMode: .fill) // Fill the frame
                        .clipShape(Rectangle()) // Clip overlaping parts
                
                .overlay(TopCellInfo(item: self.item!),alignment: .bottom)
                }
                
            } else {
                Text("item == nil")
            }
        }.cornerRadius(5).shadow(color: .black, radius: 5)
    
    }
}

struct NewsTopItemCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsTopItemCell()
    }
}

struct TopCellInfo: View {
    
    var item: NewsArticleViewModel
    
    var body: some View {
        ZStack(alignment: .bottom){
            Rectangle().fill(Color.black.opacity(0.2)).frame(height: 50, alignment: .bottom)
            
            Text(self.item.title)
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .lineLimit(2).padding([.leading, .trailing], 8).padding([.bottom], 4)
        }
    }
}
