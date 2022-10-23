//
//  CountrySheetView.swift
//  FossTube
//
//  Created by Shrey Soni on 09/08/22.
//

import SwiftUI


struct CountrySheetView: View {
    var localStorage = LocalStorage()
    @Binding var selectedCountryCode: String
    var closeSheet:()->()
    
    
    var viewModel = CountrySheetViewModel()
    var body: some View {
        NavigationView {
            List(self.viewModel.regionList.items, id: \.id) { region in
                CountryView(
                    countryData: region,
                    selectedCountryCode: $selectedCountryCode,
                    closeSheet : closeSheet
                )
            }
            .navigationTitle("Region List")
        }
    }
}
