//
//  SearchModel.swift
//  FossTube
//
//  Created by Shrey Soni on 11/10/22.
//

import Foundation

struct SearchModel :Codable,Hashable {
    var items: [Item]
    var nextpage: String?
    var suggestion: String?
    var corrected: Bool?
}

struct Item :Codable,Hashable{
    
    let name: String?
    let thumbnail: String?
    let url: String?
    let itemDescription: String?
    let subscribers, videos: Int?
    let verified: Bool?
    let title: String?
    let uploaderName: String?
    let uploaderUrl: String?
    let uploaderAvatar: String?
    let uploadedDate, shortDescription: String?
    let duration, views, uploaded: Int?
    let uploaderVerified: Bool?
}
