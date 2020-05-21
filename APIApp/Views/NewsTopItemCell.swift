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
    var imageWidth: CGFloat = UIScreen.main.bounds.width - 16
    var imageHeight: CGFloat = CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 < 200 ? CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 : 200.0
    
    let supportSizeClass: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    init(item: NewsArticleViewModel?, supportSizeClass: Bool = false){
        self.item = item
        self.supportSizeClass = supportSizeClass
        if !supportSizeClass || self.horizontalSizeClass == .compact{
             imageWidth = UIScreen.main.bounds.width - 16
             imageHeight = CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 < 200 ? CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 : 200.0
        } else if supportSizeClass{
            imageWidth = (UIScreen.main.bounds.width - 32)/2
            imageHeight = CGFloat(imageWidth)*9.0/16.0 < 200 ? CGFloat(UIScreen.main.bounds.width - 16)*9.0/16.0 : 200.0
        }
    }

    @ViewBuilder // https://stackoverflow.com/a/57323368/1571228
    var body: some View {
        ZStack{
            Rectangle().fill(Color.white).frame(width:imageWidth, height: 200)
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
        NewsTopItemCell(item: nil)
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
