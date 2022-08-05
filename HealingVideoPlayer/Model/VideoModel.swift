//
//  VideoModel.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/04.
//

import Foundation
import AVFoundation
import AVKit

class Video {
    let videoName: String
    let thumnail: UIImage
    let duration: Int
    
    init(videoName: String) {
        self.videoName = videoName
        
        let url = Bundle.main.url(forResource: videoName, withExtension: "mp4")!
        let asset = AVURLAsset(url: url, options: nil)
        
        // thumnail(썸네일) 구하기
        var thumnailImage = UIImage(named: "defaultThumnail")
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTime(value: 0, timescale: 1), actualTime: nil)
            thumnailImage = UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
        }
        self.thumnail = thumnailImage!
        
        // duration(플레이타임) 구하기
        let duration: CMTime = asset.duration
        self.duration = Int(CMTimeGetSeconds(duration))
    }
}
