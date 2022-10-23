//
//  CountrySheetViewModel.swift
//  FossTube
//
//  Created by Shrey Soni on 14/08/22.
//

import Foundation
import Combine

class CountrySheetViewModel {
    var regionList = RegionList(
    items: [
        CountryData(id: "US", name: "America", flagIconUrl: "🇺🇸"),
        CountryData(id: "CA", name: "Canada", flagIconUrl: "🇨🇦"),
        CountryData(id: "IN", name: "India", flagIconUrl: "🇮🇳"),
        CountryData(id: "NL", name: "Netherlands", flagIconUrl: "🇳🇱"),
        CountryData(id: "GB", name: "United Kingdom", flagIconUrl: "🇬🇧"),
    ]);
}
