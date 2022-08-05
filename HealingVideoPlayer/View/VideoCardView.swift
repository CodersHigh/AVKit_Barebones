//
//  VideoCardView.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/05.
//

import SwiftUI

struct VideoCardView: View {
    var video: Video
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                // 이미지
                ZStack {
                    Image(uiImage: (video.thumnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    Rectangle()
                        .cornerRadius(20)
                        .foregroundColor(.black.opacity(0.4))
                }
                .padding(.bottom, 7)
                // 텍스트
                VStack(alignment: .leading) {
                    Text("\(video.duration) sec")
                        .font(.caption).bold()
                    Text(video.videoName)
                        .font(.title3).bold()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            
            // 플레이 기호
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title3)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
        }
    }
}
