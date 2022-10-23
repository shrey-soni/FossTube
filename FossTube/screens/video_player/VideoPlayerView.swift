//
//  VideoPlayerView.swift
//  FossTube
//
//  Created by Shrey Soni on 11/09/22.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var avPlayer:AVPlayer
    
    init(avPlayer: AVPlayer) {
        self.avPlayer = avPlayer
    }
    
    var body:some View{
        CustomVideoPlayer(avPlayer: avPlayer)
            .onAppear {
                avPlayer.play()
            }
            .onDisappear{
                avPlayer.pause()
            }
            .aspectRatio(16/10,contentMode: .fit)
    }
}


struct CustomVideoPlayer: UIViewControllerRepresentable {
    let avPlayer : AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = avPlayer
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
