//
//  Apis.swift
//  FossTube
//
//  Created by Shrey Soni on 09/08/22.
//

import Foundation

class BaseUrl{
    static var kavinRocks:String="https://pipedapi.kavin.rocks"
}

var baseUrl=BaseUrl.kavinRocks

class ApiEndpoints{
    static var trending = baseUrl+"/trending/"
    static var stream = baseUrl+"/streams/"
    static var search = baseUrl+"/search"
    static var suggestions = baseUrl+"/suggestions"
    static var channel = baseUrl+"/channel/"
    static var webViewBaseUrlMap = [
        BaseUrl.kavinRocks:"https://piped.kavin.rocks",
    ]
    
}

