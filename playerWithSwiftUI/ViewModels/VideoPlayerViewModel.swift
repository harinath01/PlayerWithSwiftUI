import Foundation
import AVKit

class VideoPlayerViewModel: NSObject, ObservableObject {
    @Published var player: AVPlayer!
    @Published var playerStatus: PlayerStatus = .paused
    
    private var orgCode: String
    private var videoId: String
    private var accessToken: String
    
    
    init(orgCode: String, videoId: String, accessToken: String) {
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
        super.init()
        self.setUpPlayer()
    }
    
    private func setUpPlayer(){
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken) { videoDetails, error in
            if let videoDetails = videoDetails {
                self.player = AVPlayer(url: URL(string: videoDetails.playbackURL)!)
                self.addObservers()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func addObservers(){
        player.addObserver(self, forKeyPath: "timeControlStatus", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let player = object as? AVPlayer {
            if keyPath == "timeControlStatus" {
                handlePlayerStatusChange(for: player)
            }
        }
    }
    
    private func handlePlayerStatusChange(for player: AVPlayer){
        switch player.timeControlStatus {
        case .playing:
            playerStatus = .playing
        case .paused:
            playerStatus = .paused
        case .waitingToPlayAtSpecifiedRate:
            break
        @unknown default:
            break
        }
    }
}

enum PlayerStatus {
    case playing
    case paused
    case finished
    case buffering
}

extension VideoPlayerViewModel: PlayerControlDelegate{
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
}
