//
//  HomePageView.swift
//  FossTube
//
//  Created by Shrey Soni on 08/08/22.
//

import SwiftUI

struct HomePageView: View {    
    var body: some View {
        TabView{
            TrendingView()
                .padding(.top)
                .tabItem {
                    Label("Trending",systemImage: "bolt.circle")
                }
                .tag(1)
            FavouritesView()
                .tabItem {
                    Label("Favourites",systemImage: "star.circle.fill")
                }
                .tag(2)
            SearchScreen()
                .tabItem {
                    Label("Search",systemImage: "magnifyingglass.circle.fill")
                }
                .tag(3)
            
        }
        .ignoresSafeArea()

    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

