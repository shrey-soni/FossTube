//
//  SuggestionViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 11/10/22.
//

import Foundation
import Combine

// SuggestionModel is [String]

class SuggestionViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var suggestionList: [String]?
    
    func getSuggestedString(query:String)->Void{
        var url = URL.init(string: ApiEndpoints.suggestions);
        var absoluteUrl:String
        if #available(iOS 16.0, *) {
            url?.append(queryItems: [URLQueryItem(name: "query", value: query)])
            absoluteUrl=url!.absoluteString;
        } else {
            absoluteUrl = CommonUtils.addQueryParams(url: url!, newParams: [URLQueryItem.init(name: "query", value: query)])!.absoluteString
        }
        if (url != nil) {
            NetworkManager.shared.getData(absoluteUrl: absoluteUrl, id: nil,type: Array.self)
                .sink { ending in
                    print(ending)
                } receiveValue: { [weak self] suggestions in
                    self?.suggestionList = suggestions
                }
                .store(in: &cancellables)
        }

    }
}
