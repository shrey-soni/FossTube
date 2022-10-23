//
//  EmptyView.swift
//  FossTube
//
//  Created by Shrey Soni on 12/10/22.
//

import SwiftUI
import NukeUI

struct EmptyView: View {
    @State var randomGifString = "https://media.giphy.com/media/26hkhPJ5hmdD87HYA/giphy.gif"
    func setRandomGifSource(){
        let list = ["https://media.giphy.com/media/26hkhPJ5hmdD87HYA/giphy.gif","https://media.giphy.com/media/8CMmJ6F8hTxqX7Ts5k/giphy.gif","https://media.giphy.com/media/giXLnhxp60zEEIkq8K/giphy.gif","https://media.giphy.com/media/VivFIsgKv5wCcTkajh/giphy.gif","https://media.giphy.com/media/RHBAyK1GxTgPe/giphy.gif","https://media.giphy.com/media/ZBPlI1KjKtb63dvzyX/giphy.gif","https://media.giphy.com/media/zK1bE53ewn1rAQv05L/giphy.gif","https://media.giphy.com/media/SVSvQ0NuyxmvkP9jU8/giphy.gif","https://media.giphy.com/media/Takij2HmE2ksZcumA5/giphy-downsized-large.gif"]
        let randomInt = Int.random(in: 0..<list.count)
        randomGifString = list[randomInt]
    }
    
    var body: some View {
        VStack{
            Spacer()
            LazyImage(source: randomGifString,resizingMode: .aspectFit)
                .frame(width: 500,height: 500)
                .padding(.top)
                .onTapGesture(perform: setRandomGifSource)
            Spacer()
        }
        .padding()
        .onAppear(perform: setRandomGifSource)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
