//
//  VideoDataModel.swift
//  FossTube
//
//  Created by Shrey Soni on 08/08/22.
//

import Foundation

struct VideoDataModel : Encodable, Decodable, Hashable {
    var url, title: String?
    var thumbnail: String?
    var uploaderUrl, uploaderName: String?
    var uploaderAvatar: String?
    var uploadedDate: String?
    var shortDescription: String?
    var duration, views, uploaded: Int?
    var uploaderVerified: Bool?
}
