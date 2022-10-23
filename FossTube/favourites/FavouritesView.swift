//
//  RSSView.swift
//  FossTube
//
//  Created by Shrey Soni on 08/08/22.
//

import SwiftUI
import NukeUI

struct FavouritesView: View {
    @ObservedObject var favouriteViewModel = FavouritesViewModel()
    
    @State var favouriteChannelList:[FavouriteChannel]=[]
    
    
    func updateFavouriteChannelList(){
        favouriteChannelList=favouriteViewModel.getFavouriteChannelList();
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(favouriteChannelList ,id: \.channelUrl){
                        fav in
                        FavouriteChannelListView(channelData:fav)
                    }.emptyPlaceholder(favouriteChannelList){
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Favourites")
        }
        .onAppear(perform: updateFavouriteChannelList)
    }
}

struct FavouriteChannelListView:View{
    @ObservedObject private var channelDetailViewModel = ChannelDetailViewModel()
    
    var channelData:FavouriteChannel
    @State var navigateToChannelScreen = false;
    
    
    func fetchChannelDetails(){
        let channelId = CommonUtils.getChannelIdFromUrl(url: channelData.channelUrl) ;
        channelDetailViewModel.getChannelDetails(channelId: channelId) ;
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(channelData.channelName)
                .font(.system(size: 25,weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack{
                    ForEach(channelDetailViewModel.channelDetail?.relatedStreams ?? [], id:\.url){
                        channelVideo in
                        FavouriteChannelVideo(videoData: channelVideo)
                    }
                }
            }
            .onAppear(perform: fetchChannelDetails)
        }.padding(.vertical)
    }
}

struct FavouriteChannelVideo:View{
    let videoData:VideoDataModel
    @State var showPlayerSheet = false;
    
    func shortVideoThumbnail(src:String)->some View{
        return ZStack{
            LazyImage(source:src)
                .blur(radius: 5)
                .frame(width:352,height: 220)
            LazyImage(source: src, resizingMode: .aspectFit)
                .frame(height: 220)
        }
        .frame(width:352,height: 220)
        .cornerRadius(20.0)
    }
    
    func normalVideoThumbnail(v:VideoDataModel)->some View{
        return ZStack(alignment: .bottomTrailing){
            LazyImage(source: v.thumbnail ?? "",resizingMode: .aspectFill)
                .frame(width:352,height: 220)
                .cornerRadius(20.0)
            duration(v: v)
                .padding(12)
                .cornerRadius(10.0)
        }
    }

    
    func videoTitle(v:VideoDataModel)->some View{
        return VStack{
            Text(v.title ?? "")
                .frame(width:352)
                .font(.system(size: 20,weight: .medium))
                .multilineTextAlignment(.leading)
            HStack{
                Text(v.uploadedDate!)
                Spacer()
                Text(CommonUtils.numberAbbreviator(num: v.views!))
                Label("", systemImage: "eye")
            }
            .padding(1)
        }
    }
    
    func duration(v:VideoDataModel)-> some View {
        return Text(CommonUtils.getStringifiedDuration(duration: CommonUtils.secondsToHoursMinutesSeconds(seconds: v.duration!)))
            .foregroundColor(.white)
            .padding(5)
            .background(Color.gray.opacity(0.8))
    }
    
    func sheetVideoPlayerContent(v:VideoDataModel) -> some View{
        return VideoPlayerScreen(videoData: v)
    }
    
    var body: some View{
        VStack{
            if(videoData.duration! == 0){
                shortVideoThumbnail(src: videoData.thumbnail ?? "")
            }else{
                normalVideoThumbnail(v: videoData)
            }
            videoTitle(v: videoData)
                .sheet(isPresented: $showPlayerSheet){
                    sheetVideoPlayerContent(v: videoData)
                }
            
        }
        .onTapGesture {
            showPlayerSheet.toggle()
        }
        .padding(.horizontal)
    }
}
