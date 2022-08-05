//
//  VideoPlayView.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/05.
//

import SwiftUI
import AVKit

struct VideoPlayView: View {
    @StateObject var viewModel = PlayerViewModel()
    let video: Video
    
    var body: some View {
        AVVideoPlayer(viewModel: viewModel, video: video)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.play()
            }
            .onDisappear {
                viewModel.pause()
            }
    }
}

struct AVVideoPlayer: UIViewControllerRepresentable {
    @ObservedObject var viewModel: PlayerViewModel
    let video: Video
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        let videoPath = Bundle.main.path(forResource: video.videoName, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        viewModel.player = AVPlayer(url: videoPathURL)
        
        let vc = AVPlayerViewController()
        vc.player = viewModel.player
        vc.canStartPictureInPictureAutomaticallyFromInline = true
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }
}
