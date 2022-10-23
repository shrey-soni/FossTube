

//
//  FeedView.swift
//  FossTube
//
//  Created by Shrey Soni on 08/08/22.
//

import SwiftUI

struct TrendingView: View {
    @ObservedObject var trendingVideoViewModel = TrendingVideosViewModel()
    var localStorage = LocalStorage()
    @State var showCountryChangeSheet = false
    @State var selectedCountryCode : String
    var previouslySecelctedCountry:String=""
    
    
    init() {
        selectedCountryCode = localStorage.getStoredValue(key: StorageKeys.selectedRegionCode) as? String ?? Constants.defaultCountryCode
        previouslySecelctedCountry=selectedCountryCode
        fetchTrendingVideos()
    }
    
    func fetchTrendingVideos(){
        trendingVideoViewModel.getTrendingVideoList(regionCode: selectedCountryCode)
    }
    
    func closeSheet(){
        
        if(previouslySecelctedCountry != selectedCountryCode){
            fetchTrendingVideos()
        }
        
        showCountryChangeSheet=false;
    }
    
    func getEmptyVideoListObject()->[VideoDataModel]{
        return [
            VideoDataModel(
                url: "", title: "", thumbnail: "", uploaderUrl: "", uploaderName: "",
                uploaderAvatar: "", uploadedDate: "", duration: 0, views: 0, uploaded: 0,
                uploaderVerified: false
            )
        ]
    }
    
    var body: some View {
        NavigationView{
            if(trendingVideoViewModel.trendingVideoList == nil){
                ProgressView()
            }
            else{
                ScrollView{
                    LazyVStack(spacing: 20){
                        ForEach(trendingVideoViewModel.trendingVideoList ?? getEmptyVideoListObject(),id: \.self){
                            video in
                            TrendingVideoTile(videoData:video)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                        }
                    }
                }
                .emptyPlaceholder(trendingVideoViewModel.trendingVideoList!){
                    Text("Empty")
                }
                .navigationTitle("Trending")
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button {
                            showCountryChangeSheet=true
                        } label: {
                            Label("Change Country", systemImage: "globe")
                        }
                        .sheet(isPresented: $showCountryChangeSheet){
                            CountrySheetView(
                                selectedCountryCode: $selectedCountryCode,
                                closeSheet: closeSheet
                            )
                        }
                    }
                }
            }
        }
    }
}
