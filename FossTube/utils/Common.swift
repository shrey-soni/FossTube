//
//  Common.swift
//  FossTube
//
//  Created by Shrey Soni on 06/09/22.
//

import Foundation
import UIKit

class CommonUtils{
    static func addQueryParams(url: URL, newParams: [URLQueryItem]) -> URL? {
        let urlComponents = NSURLComponents.init(url: url, resolvingAgainstBaseURL: false)
        guard urlComponents != nil else { return nil; }
        if (urlComponents?.queryItems == nil) {
            urlComponents!.queryItems = [];
        }
        urlComponents!.queryItems!.append(contentsOf: newParams);
        return urlComponents?.url;
    }
    
    static func secondsToHoursMinutesSeconds(seconds: Int) -> (Double, Double, Double) {
      let (hr,  minf) = modf(Double(seconds) / 3600)
      let (min, secf) = modf(60 * minf)
      return (hr, min, 60 * secf)
    }
    
    static func getStringifiedDuration(duration: (Double,Double,Double))->String{
        let (hr,min,sec)=duration
        var returnable = ""
        if(hr != 0){
            returnable += String(Int(hr))+":"
        }
        var min_s=String(Int(min))
        if(min_s == "0"){
            min_s="0"+min_s
        }
        returnable += min_s+":"
        var sec_s = String(Int(sec))
        if (sec_s.endIndex == "1".endIndex){
            sec_s="0"+sec_s
        }
        returnable += sec_s
        return returnable
    }
    
    static func getVideoID(videoData: VideoDataModel)->String{
        return "vid_"+videoData.url!
    }
    
    static func getAbsoluteVideoStreamingUrl(video:VideoDataModel)->String?{
        let url=baseUrl+video.url!
        print(url)
        return url
    }
    
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    static func getVideoIdFromWatchUrl(url:String)->String{
        print(url)
        if(url.hasPrefix("/watch?v=")){
            return url.components(separatedBy: "=").last ?? ""
        }
        return ""
    }
    
    static func numberAbbreviator(num:Int)->String{
        var n=Double(num);
        var s=String(Int(n))
        if(n>=1000 && n<1000000){
            n/=1000
            s=String(floor(n).rounded())+"K"
        }
        else if(n>=1000000 && n<1000000000){
            n/=1000000
            s=String(floor(n).rounded())+"M"
        }
        else{
            n/=1000000000
            s=String(floor(n).rounded())+"B"
        }
        return s
    }
    static func getChannelIdFromUrl(url:String)->String{
        print(url)
        if(url.hasPrefix("/channel/")){
            return url.components(separatedBy: "/channel/").last ?? ""
        }
        return ""
    }
}
