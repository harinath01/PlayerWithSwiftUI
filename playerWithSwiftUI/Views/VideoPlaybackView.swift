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
}


struct VideoPlaybackView: UIViewRepresentable {
    var player: AVPlayer
    
    func makeUIView(context: Context) -> VideoPlaybackUIView {
        let videoPlaybackView = VideoPlaybackUIView()
        videoPlaybackView.player = self.player
        return videoPlaybackView
    }
    
    func updateUIView(_ uiView: VideoPlaybackUIView, context: Context) { }
}
