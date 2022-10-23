//
//  ChannelDetailViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 12/10/22.
//

import Foundation
import Combine


class ChannelDetailViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var channelDetail: ChannelDetail?
    
    func getChannelDetails(channelId:String)->Void{
        let url = URL.init(string: ApiEndpoints.channel+channelId);
        if (url != nil) {
            let absoluteUrl = url?.absoluteString
            NetworkManager.shared.getData(absoluteUrl: absoluteUrl!, id: nil,type: ChannelDetail.self)
                .sink { ending in
                    print(ending)
                } receiveValue: { [weak self] channelD in
                    self?.channelDetail = channelD
                    print(channelD)
                }
                .store(in: &cancellables)
        }
    }
}
