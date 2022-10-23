//
//  LocalStorage.swift
//  FossTube
//
//  Created by Shrey Soni on 29/08/22.
//

import Foundation

class LocalStorage{
    var userDefaults=UserDefaults.standard
    
    func getStoredValue(key:String) -> Any? {
        if( userDefaults.object(forKey: key) != nil ){
            return userDefaults.value(forKey: key)
        }
        else{
            return nil
        }
    }
    
    func setStoragePair(key:String, val:Any?) {
        userDefaults.set(val, forKey: key)
    }
    
    func deleteStorageKey(key:String){
        userDefaults.removeObject(forKey: key)
    }
}

class StorageKeys{
    static let selectedRegionCode = "selected_region_code" // ex: { key: "selected_region_code" , value: "IN" }
    static let favouriteChannels = "favourite_channels" // ex: {key: "favourite_channels", value: [String]}
    static let searchHistory = "search_history" // ex: {key: "search_history, value: [String]"}
}
