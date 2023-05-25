import Foundation
import SwiftUI
import UIKit
import AVKit

class VideoPlaybackUIView: UIView {
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
    private var orgCode: String!
    private var videoId: String!
    private var accessToken: String!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(orgCode: String!, videoId: String!, accessToken: String!){
        super.init(frame: .zero)
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
        self.backgroundColor = .black
        self.configurePlayerWithVideo()
    }
    
    private func configurePlayerWithVideo(){
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken){ videoDetails, error in
            if let videoDetails = videoDetails {
                self.player = AVPlayer(url: URL(string: videoDetails.playbackURL)!)
                self.player?.play()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}


struct VideoPlaybackView: UIViewRepresentable {
    var orgCode: String
    var videoId: String
    var accessToken: String
    
    func makeUIView(context: Context) -> VideoPlaybackUIView {
        return VideoPlaybackUIView(
            orgCode: orgCode,
            videoId: videoId,
            accessToken: accessToken
        )
    }
    
    func updateUIView(_ uiView: VideoPlaybackUIView, context: Context) { }
}
