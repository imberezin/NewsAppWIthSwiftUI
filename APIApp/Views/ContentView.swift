//
//  ContentView.swift
//  APIApp
//
//  Created by Israel Berezin on 2/18/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI
import URLImage


enum Tab: Int {
    case worldNews, businessNews, appleNews
}

struct ContentView: View {
    
    @State var selectedTab = Tab.businessNews
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }

    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }

    var body: some View {
        
        TabView(selection: $selectedTab) {
            WorldNews().tabItem{
                self.tabbarItem(text: "World News", image: "globe")
            }.tag(Tab.worldNews)

            BusinessNews().tabItem{
                 self.tabbarItem(text: "Business", image: "bag")
            }.tag(Tab.businessNews)
            AppleNews().tabItem{
                self.tabbarItem(text: "Apple News", image: "a.circle")
            }.tag(Tab.appleNews)
        }.accentColor(.red)


       
        
    }
    
 
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
