//
//  Webview.swift
//  FossTube
//
//  Created by Shrey Soni on 20/09/22.
//

import SwiftUI
import WebKit

struct Webview: View {
    var url:String
    var body: some View {
        NavigationView{
            SwiftUIWebView(url: url)
        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

struct Webview_Previews: PreviewProvider {
    static var previews: some View {
        Webview(url: "")
    }
}


struct SwiftUIWebView: UIViewRepresentable {
    var url:String
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    init(url:String) {
        webView = WKWebView(frame: .zero)
        print(url)
        webView.load(URLRequest(url: URL(string: ApiEndpoints.webViewBaseUrlMap[baseUrl]!+url)!))
        self.url=url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
