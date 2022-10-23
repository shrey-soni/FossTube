//
//  ViewExtensions.swift
//  FossTube
//
//  Created by Shrey Soni on 11/09/22.
//

import Foundation
import SwiftUI
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>, pageTitle:String?) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle(pageTitle ?? "")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
