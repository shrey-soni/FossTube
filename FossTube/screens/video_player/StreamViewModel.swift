//
//  StreamViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 30/09/22.
//

import Foundation
import Combine

class StreamVidoeViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var streamVideoData: StreamModel?
    
    func getStreamData(videoId:String)->Void{
        let url = URL.init(string: ApiEndpoints.stream+videoId);
        var absoluteUrl:String
        if (url != nil) {
            absoluteUrl=url!.absoluteString;
            NetworkManager.shared.getData(absoluteUrl: absoluteUrl, id: nil,type: StreamModel.self)
                .sink { ending in
                    print(ending)
                } receiveValue: { [weak self] streamData in
                    self?.streamVideoData = streamData
                    print(streamData)
                }
                .store(in: &cancellables)
        }

    }
}
