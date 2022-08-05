//
//  VideoPlayView.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/05.
//

import SwiftUI
import AVKit

struct VideoPlayView: View {
    var video: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                let videoPath = Bundle.main.path(forResource: video.videoName, ofType: "mp4")
                let videoPathURL = URL(fileURLWithPath: videoPath!)
                player = AVPlayer(url: videoPathURL)
                player.play()
            }
    }
}
