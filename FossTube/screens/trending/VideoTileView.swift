//
//  HomeFeedVideoView.swift
//  FossTube
//
//  Created by Shrey Soni on 08/08/22.
//

import SwiftUI
import NukeUI

struct TrendingVideoTile: View {
    @State var showPlayerSheet = false;
    var videoData : VideoDataModel
    
    var videoTitle: some View{
        HStack{
            LazyImage(source: videoData.uploaderAvatar,resizingMode: .aspectFit)
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: .gray, radius: 2.0, x: 1.0, y: 1.0)
            
            Text(videoData.title!.codingKey.stringValue)
                .multilineTextAlignment(.leading)
                
        }
    }
    
    var videoThumbnail:some View{
        LazyImage(source: videoData.thumbnail,resizingMode: .aspectFit)
            .frame(height: 220)
            
    }
    
    var duration: some View {
        Text(CommonUtils.getStringifiedDuration(duration: CommonUtils.secondsToHoursMinutesSeconds(seconds: videoData.duration!)))
            .foregroundColor(.white)
            .padding(2)
            .background(Color.gray.opacity(0.8))
    }
    
    func videoPlayerBottomSheet()->some View{
        return VideoPlayerScreen(videoData: videoData);
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            videoThumbnail
                .overlay(duration.shadow(color: .gray, radius: 2.0, x: 1.0, y: 1.0),alignment: .bottomTrailing)
            Divider()
            videoTitle
        }.onTapGesture {
            showPlayerSheet.toggle()
        }.sheet(isPresented: $showPlayerSheet){
            videoPlayerBottomSheet();
        }
    }
}
