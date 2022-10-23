//
//  FavouritesModel.swift
//  FossTube
//
//  Created by Shrey Soni on 10/10/22.
//

import Foundation

struct Favourite{
    var channels: [FavouriteChannel]
    var videos: [String]
}

struct FavouriteChannel:Codable,Equatable{
    let channelUrl: String
    let channelName: String
    let channelAvatar: String
}
