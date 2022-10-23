//
//  ChannelDetailScreen.swift
//  FossTube
//
//  Created by Shrey Soni on 12/10/22.
//

import SwiftUI
import NukeUI

struct ChannelDetailScreen: View {
    var channelDetail : ChannelDetail
    func getEmptyView()->some View{
        return EmptyView()
    }
    
    var body: some View {
        ScrollView(.vertical){
            NavigationView{
                List(channelDetail.relatedStreams ?? [], id: \.url){
                    video in
                    TrendingVideoTile(videoData: video)
                }
                .emptyPlaceholder(channelDetail.relatedStreams ?? [], getEmptyView)
                .navigationTitle(channelDetail.name ?? "")
                
            }
        }
    }
}
