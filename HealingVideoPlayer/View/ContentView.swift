//
//  ContentView.swift
//  AVKit_Barebones
//
//  Created by 이로운 on 2022/08/04.
//

import SwiftUI

struct ContentView: View {
    
    // 파일 이름에서 .mp4 확장자를 제거한 이름을 담은 Video 배열 생성
    private var videos: [Video] = {
        guard let path = Bundle.main.resourcePath, let files = try? FileManager.default.contentsOfDirectory(atPath: path) else { return [] }
        var videos: [Video] = []
        for fileName in files where fileName.hasSuffix("mp4") {
            let videoName = fileName.replacingOccurrences(of: ".mp4", with: "")
            let video = Video(videoName: videoName)
            videos.append(video)
        }
        return videos
    }()
    
    var body: some View {
        List {
            ForEach(0..<self.videos.count) { index in
                Image(uiImage: (videos[index].thumnail))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding(.top, 7)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}
