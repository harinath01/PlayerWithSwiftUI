import Foundation
import AVKit

class VideoPlayerViewModel: NSObject, ObservableObject {
    @Published var player: AVPlayer!
    @Published var playerStatus: PlayerStatus = .paused
    @Published var currentTime: Float64?
    @Published var bufferedDuration: Float64?
    @Published var isFullScreen = false
    
    private let orgCode: String
    private let videoId: String
    private let accessToken: String
    private var isSeeking: Bool = false
    
    var videoDuration: Float64 {
        player?.durationInSeconds ?? 0.0
    }
    
    private var timeObserver: Any!
    
    init(orgCode: String, videoId: String, accessToken: String) {
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
        super.init()
        initializePlayer()
    }
    
    private func initializePlayer() {
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken) { [weak self] videoDetails, error in
            guard let self = self else { return }
            
            if let videoDetails = videoDetails {
                self.player = AVPlayer(url: URL(string: videoDetails.playbackURL)!)
                self.addObservers()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func addObservers(){
        addPlayerTimeObserver()
        addPlayerBufferingObservers()
        addPlayerStatusObserver()
    }
    
    private func addPlayerTimeObserver() {
        let interval = CMTime(value: 1, timescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] progressTime in
            guard let self = self else { return }
            if !self.isSeeking {
                self.currentTime = CMTimeGetSeconds(progressTime)
            }
            self.bufferedDuration = self.player?.bufferedDuration()
        }
    }
    
    private func addPlayerStatusObserver() {
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options: .new, context: nil)
    }
    
    private func addPlayerBufferingObservers() {
        player?.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp), options: .new, context: nil)
        player?.currentItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if let player = object as? AVPlayer {
            handlePlayerStatusChange(for: player)
        } else if let playerItem = object as? AVPlayerItem, let keyPath = keyPath {
            handleBufferStatusChange(of: playerItem, keyPath: keyPath)
        }
    }
    
    private func handlePlayerStatusChange(for player: AVPlayer) {
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
    
    private func handleBufferStatusChange(of playerItem: AVPlayerItem, keyPath: String) {
        switch keyPath {
        case #keyPath(AVPlayerItem.isPlaybackBufferEmpty):
            if playerItem.isPlaybackBufferEmpty {
                playerStatus = .buffering
            }
        case #keyPath(AVPlayerItem.isPlaybackLikelyToKeepUp):
            if playerItem.isPlaybackLikelyToKeepUp {
                playerStatus = self.player.timeControlStatus == .playing ? .playing : .paused
            }
        default:
            break
        }
    }
}

extension VideoPlayerViewModel: PlayerControlDelegate {
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    func forward() {
        let seekTo = self.player.currentTimeInSeconds + 10
        if seekTo > videoDuration{
            return
        }
        goTo(seconds: seekTo)
    }
    
    func rewind() {
        var seekTo = self.player.currentTimeInSeconds - 10
        if seekTo < 0 {
            seekTo = 0
        }
        goTo(seconds: seekTo)
    }
    
    func goTo(seconds: Float64) {
        isSeeking = true
        currentTime = seconds
        let seekTime = CMTime(value: Int64(seconds), timescale: 1)
        player?.seek(to: seekTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero) { [weak self] _ in
            guard let self = self else { return }
            self.isSeeking = false
        }
    }
    
    func enterFullScreen() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        isFullScreen = true
    }
    
    func exitFullScreen() {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        isFullScreen = false
    }
}

enum PlayerStatus {
    case playing
    case paused
    case finished
    case buffering
}
