//
//  ChannelDetailModel.swift
//  FossTube
//
//  Created by Shrey Soni on 12/10/22.
//

import Foundation

struct ChannelDetail:Codable,Hashable {
    let id, name: String?
    let avatarUrl, bannerUrl: String?
    let description, nextpage: String?
    let subscriberCount: Int?
    let verified: Bool?
    let relatedStreams: [VideoDataModel]?
}
