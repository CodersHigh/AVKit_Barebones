//
//  VideoModel.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/04.
//

import Foundation
import AVKit

class Video {
    let videoName: String
    let duration: Int
    
    init(videoName: String) {
        self.videoName = videoName
        
        let url = Bundle.main.url(forResource: videoName, withExtension: "mp4")!
        let duration: CMTime = AVURLAsset(url: url, options: nil).duration
        self.duration = Int(CMTimeGetSeconds(duration))
    }
}
