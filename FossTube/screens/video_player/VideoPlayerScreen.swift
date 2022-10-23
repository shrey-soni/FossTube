//
//  VideoPlayerScreen.swift
//  FossTube
//
//  Created by Shrey Soni on 19/09/22.
//

import SwiftUI
import NukeUI
import AVKit

struct VideoPlayerScreen: View {
    var videoData : VideoDataModel
    @Namespace var namespace
    @ObservedObject var streamViewModel = StreamVidoeViewModel()
    @ObservedObject var favouritesViewModel = FavouritesViewModel()
    var segmentedHeaders = ["Related Videos","Comments"]
    @State var selectedItem = "Related Videos"
    
    init(videoData: VideoDataModel) {
        self.videoData = videoData
        let videoId = CommonUtils.getVideoIdFromWatchUrl(url:videoData.url!)
        streamViewModel.getStreamData(videoId: videoId)
    }
    
    
    
    func getHLS()->String{
        return (streamViewModel.streamVideoData?.hls)!
    }
    
    var webView:some View{
        NavigationLink(destination: Webview(url:videoData.url!)){
            Label("Open in web", systemImage: "safari")
        }
    }
    
    var options:some View{
        Menu{
            if(isChannelFavourite()){
                Button(action:removeFromFavourite){
                    Label("Remove channel from favourites",systemImage: "heart.slash")
                }
            }else{
                Button(action:addToFavourite){
                    Label("Add channel to favourites",systemImage: "heart")
                }
            }
            NavigationLink(destination: Webview(url:videoData.url!)){
                Label("Open in web", systemImage: "safari")
            }
        }
        label: {
           Label("", systemImage: "ellipsis")
        }
    }
    
    var videoTitle: some View{
        VStack(alignment: .leading){
            HStack{
                LazyImage(source: videoData.uploaderAvatar,resizingMode: .aspectFit)
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 2.0, x: 1.0, y: 1.0)
                
                Text(videoData.title!.codingKey.stringValue)
                    .foregroundColor(.black)
                    .font(.body)
                    .multilineTextAlignment(.leading)

            }
            HStack{
                Text(videoData.uploadedDate!)
                Spacer()
                options
                Spacer()
                Text(CommonUtils.numberAbbreviator(num: videoData.views!))
                Label("", systemImage: "eye")
                
            }
            Divider()
        }.padding(.horizontal)
    }
    
    var reccomendationAndCommentView:some View{
        ScrollViewReader{ sp in
            ScrollView{
                VStack(alignment: .leading,spacing: 10){
                    AnyView(videoTitle)
                    Picker("Pick", selection: $selectedItem) {
                        ForEach(segmentedHeaders, id: \.self) { item in
                            Text(item)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    if(selectedItem == segmentedHeaders[0]){
                        ForEach( (streamViewModel.streamVideoData?.relatedStreams)!, id: \.url) { videoData in
                            RelatedVideoView(videoData: videoData)
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    var videoDescription:some View{
        Text(videoData.shortDescription!)
            .font(.caption)
    }
    
    var videoScreenView:some View{
        VStack(alignment: .leading){
            VideoPlayerView(avPlayer: AVPlayer(url: URL(string:getHLS())!) )
            reccomendationAndCommentView
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func addToFavourite(){
        favouritesViewModel.addToFavouriteList(videoData: videoData);
    }
    
    func removeFromFavourite(){
        favouritesViewModel.removeFromFavouriteList(videoData: videoData);
    }
    
    func isChannelFavourite()->Bool{
        return favouritesViewModel.contains(videoData: videoData);
    }
    
    var body: some View {
        NavigationView {
            if(streamViewModel.streamVideoData  == nil){
                ProgressView()
            }
            else{
                videoScreenView
            }
        }
    }
}
