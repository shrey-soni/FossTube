//
//  CountryRowView.swift
//  FossTube
//
//  Created by Shrey Soni on 09/08/22.
//

import SwiftUI

struct CountryView: View {
    var countryData:CountryData
    @Binding var selectedCountryCode:String
    var closeSheet:()->()
    
    func selectNewCountryCode(value:String){
        if(selectedCountryCode != countryData.id){
            LocalStorage().setStoragePair(
                key: StorageKeys.selectedRegionCode,
                val: value
            )
        }
        selectedCountryCode=value
    }
    
    var body: some View {
        Button(
            action: {
                print("selected country : "+countryData.name)
                selectNewCountryCode(value:countryData.id)
                self.closeSheet()
            },
            label: {
                HStack{
                    Text(countryData.flagIconUrl).padding(.trailing, 10.0)
                    Text(countryData.name)
                    Spacer()
                    if(selectedCountryCode==countryData.id){
                        Image(systemName: "checkmark")
                    }
                }
            }
        )
    }
}

