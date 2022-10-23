//
//  RelatedVideosView.swift
//  FossTube
//
//  Created by Shrey Soni on 30/09/22.
//

import SwiftUI
import NukeUI

struct ReccomendationAndCommentView :View{
    var relatedStreamList: [RelatedStream]?
    var title: any View
    
    
    init(relatedStreamList: [RelatedStream]? = nil, title: any View) {
        self.relatedStreamList = relatedStreamList
        self.title = title
    }
    
    var body:some View{
        NavigationView{
            
        }
    }
}


struct RelatedVideosView:View{
    var relatedStreamList: [RelatedStream]?
    var body:some View{
        VStack(alignment: .leading,spacing: 10){
            
        }
    }
}


struct RelatedVideoView: View{
    var videoData: RelatedStream
    
    var duration: some View {
        Text(CommonUtils.getStringifiedDuration(duration: CommonUtils.secondsToHoursMinutesSeconds(seconds: videoData.duration!)))
            .foregroundColor(.white)
            .padding(2)
            .background(Color.gray.opacity(0.8))
    }
    
    var body: some View{
        NavigationLink(destination: Text("Another view")){
            HStack(alignment: .center){
                ZStack(alignment: .bottomTrailing){
                    LazyImage(source: videoData.thumbnail,resizingMode: .fill)
                        .frame(width: 160,height: 90,alignment: Alignment(horizontal: .leading, vertical: .center))
                    duration
                }
                .padding(.trailing)
                Text(videoData.title!)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
