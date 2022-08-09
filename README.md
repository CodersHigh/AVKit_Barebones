# AVKit_Barebones
<br/>

### 프로젝트 소개
- AVKit의 기본적인 기능 구현을 익히는 데에 도움을 주는 Bare-bones 프로젝트입니다.
- AVKit을 통해 **SwiftUI 기반의 힐링 비디오를 감상할 수 있는 앱**을 구현합니다.
- AVKit을 처음 활용해 보는 경우, 이 프로젝트의 코드를 살펴보면 도움이 됩니다.


https://user-images.githubusercontent.com/74223246/183541580-365bb72e-8351-4aba-89d3-4dbfa1a7dae5.MP4


<br/>
<br/>

### AVKit이란?
우선 **AVFoundation**은 미디어 처리 작업을 수행하는 프레임워크입니다.    
기본 미디어 재생 이상의 다양한 기능을 제공하지만 한 가지 아쉬운 점 : 재생 제어를 위한 표준 UI를 제공하지 않아요.   

**AVKit**은 AVFoundation 위에 구축된 보조 프레임워크로, 플랫폼의 기본 재생 환경과 일치하는 **표준 플레이어 인터페이스를 제공**할 수 있게 해줍니다.    
자막, 챕터 탐색, PIP(Picture-in-Picture) 등을 지원하죠!   

<img width="700" alt="AVKitImage" src="https://user-images.githubusercontent.com/74223246/183541752-a6ff27a7-6464-434f-916a-1fe8cca44958.png">

AVKit이 더 궁금하다면 [Apple의 공식 문서](https://developer.apple.com/documentation/avkit)를 참고해 보세요.

<br/>
<br/>

### 핵심 코드
로컬 비디오를 불러와 재생하는 핵심 코드를 참고하세요.

<br/>

**로컬 비디오의 썸네일 및 플레이타임 구하기**
```Swift
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
```

<br/>

**로컬에서 가져온 비디오의 배열 생성하기**
```Swift
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
```

<br/>

**플레이어 구현**
```Swift
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
        
        // 선택한 비디오의 이름(videoName)을 통해 비디오 경로 URL을 구해서 AVPlayer 생성 
        let videoPath = Bundle.main.path(forResource: video.videoName, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        viewModel.player = AVPlayer(url: videoPathURL)
        
        let vc = AVPlayerViewController()
        vc.player = viewModel.player
        vc.canStartPictureInPictureAutomaticallyFromInline = true
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
```
