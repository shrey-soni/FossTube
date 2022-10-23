//
//  FavouritesViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 10/10/22.
//

import Foundation
import Combine
import os

class FavouritesViewModel: ObservableObject {
    @Published var favourites: Favourite?
    
    let localStorage = LocalStorage()
    
    init() {
        self.favourites?.channels = getFavouriteChannelList();
    }
    
    func getFavouriteChannelList()->[FavouriteChannel]{
        guard let data = localStorage.getStoredValue(key: StorageKeys.favouriteChannels)
        else{
            return []
        }
        
        do {
            let tempList = try JSONDecoder().decode([FavouriteChannel].self, from: data as! Data)
            return tempList
        }
        catch{
            return []
        }
    }
    
    func deleteFavouriteChannelList(){
        localStorage.deleteStorageKey(key: StorageKeys.favouriteChannels)
    }
    
    func addToFavouriteList(videoData: VideoDataModel){
        var tempList = getFavouriteChannelList();
        let favouriteChannel = FavouriteChannel(channelUrl: videoData.uploaderUrl!, channelName: videoData.uploaderName!, channelAvatar: videoData.uploaderAvatar!)
        tempList.append(favouriteChannel);
        self.favourites?.channels = tempList
        
        do{
            deleteFavouriteChannelList()
            localStorage.setStoragePair(key: StorageKeys.favouriteChannels, val: try JSONEncoder().encode(tempList))
        }catch{
            Logger().error("Encoding error")
        }
    }
    
    func removeFromFavouriteList(videoData: VideoDataModel){
        var tempList = getFavouriteChannelList();
        let favouriteChannel = FavouriteChannel(channelUrl: videoData.uploaderUrl!, channelName: videoData.uploaderName!, channelAvatar: videoData.uploaderAvatar!)
        let index = tempList.firstIndex(of: favouriteChannel)
        if( index != nil){
            tempList.remove(at: index!)
            self.favourites?.channels = tempList
            do{
                deleteFavouriteChannelList()
                localStorage.setStoragePair(key: StorageKeys.favouriteChannels, val: try JSONEncoder().encode(tempList))
            }catch{
                Logger().error("Encoding error")
            }
        }
    }
    
    func contains(videoData: VideoDataModel)->Bool{
        let tempList = getFavouriteChannelList();
        let favouriteChannel = FavouriteChannel(channelUrl: videoData.uploaderUrl!, channelName: videoData.uploaderName!, channelAvatar: videoData.uploaderAvatar ?? "")
        let flag = tempList.contains(favouriteChannel);
        return flag;
    }
}
