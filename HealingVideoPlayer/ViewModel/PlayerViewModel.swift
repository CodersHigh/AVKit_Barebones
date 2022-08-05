//
//  PlayerViewModel.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/05.
//

import SwiftUI
import AVKit

// AVPlayer를 위한 뷰 모델
class PlayerViewModel: ObservableObject {
    var player = AVPlayer()
    
    func play() {
        player.play()
    }
        
    func pause() {
        player.pause()
    }
}
