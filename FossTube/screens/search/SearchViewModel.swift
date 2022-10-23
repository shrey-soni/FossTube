//
//  SearchViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 11/10/22.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var searchedData: SearchModel?
    
    func searchFor(query:String)->Void{
        var url = URL.init(string: ApiEndpoints.search);
        var absoluteUrl:String
        if #available(iOS 16.0, *) {
            url?.append(queryItems: [URLQueryItem(name: "q", value: query),URLQueryItem.init(name: "filter", value: "all")])
            absoluteUrl=url!.absoluteString;
        } else {
            absoluteUrl = CommonUtils.addQueryParams(url: url!, newParams: [URLQueryItem.init(name: "q", value: query),URLQueryItem.init(name: "filter", value: "all")])!.absoluteString
        }
        if (url != nil) {
            NetworkManager.shared.getData(absoluteUrl: absoluteUrl, id: nil,type: SearchModel?.self)
                .sink { ending in
                    print(ending)
                } receiveValue: { [weak self] searchData in
                    self?.searchedData = searchData
                }
                .store(in: &cancellables)
        }
    }
}

