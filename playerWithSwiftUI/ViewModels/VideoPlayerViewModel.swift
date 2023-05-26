import Foundation
import AVKit

enum PlayerStatus {
    case playing
    case paused
    case finished
    case buffering
    case readyToPlay
}


class VideoPlayerViewModel: ObservableObject {
    private var orgCode: String
    private var videoId: String
    private var accessToken: String
    
    @Published var player: AVPlayer?
    
    init(orgCode: String, videoId: String, accessToken: String) {
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
        self.setUpPlayer()
    }
    
    private func setUpPlayer(){
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken) { videoDetails, error in
            if let videoDetails = videoDetails {
                self.player = AVPlayer(url: URL(string: videoDetails.playbackURL)!)
                self.player?.play()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

extension VideoPlayerViewModel: PlayerControlDelegate{
    func pause() {}
    func play() {}
}
