//
//  TrendingFeedViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 29/08/22.
//

import Foundation
import Combine

class TrendingVideosViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var trendingVideoList: [VideoDataModel]?

    func getTrendingVideoList(regionCode:String) -> Void {
        
        let url = URL.init(string: ApiEndpoints.trending);
        var absoluteUrl:String
        if (url != nil) {
            absoluteUrl = CommonUtils.addQueryParams(url: url!, newParams: [URLQueryItem.init(name: "region", value: regionCode)])!.absoluteString
            NetworkManager.shared.getData(absoluteUrl: absoluteUrl, id: nil,type: [VideoDataModel].self)
                .sink { ending in
                    print(ending)
                } receiveValue: { [weak self] trendingVideos in
                    self?.trendingVideoList = trendingVideos
                    print(trendingVideos)
                }
                .store(in: &cancellables)
        }
    }
}
