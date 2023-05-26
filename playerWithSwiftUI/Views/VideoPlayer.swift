import SwiftUI
import AVKit

struct VideoPlayer: View {
    var orgCode: String
    var videoId: String
    var accessToken: String
    @State private var player: AVPlayer?
    
    init(orgCode: String, videoId: String, accessToken: String) {
        self.orgCode = orgCode
        self.videoId = videoId
        self.accessToken = accessToken
    }
    
    private func configurePlayerWithVideo() {
        StreamsAPIClient.fetchVideo(orgCode: orgCode, videoId: videoId, accessToken: accessToken) { videoDetails, error in
            if let videoDetails = videoDetails {
                self.player = AVPlayer(url: URL(string: videoDetails.playbackURL)!)
                self.player?.play()
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        ZStack {
            if let player = player {
                VideoPlaybackView(player: player)
            }
            ControlsView()
        }
        .onAppear(perform: configurePlayerWithVideo)
        .background(Color.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer(
            orgCode: Constants.Streams.ORG_CODE,
            videoId: Constants.Streams.NON_DRM_VIDEO_ID,
            accessToken: Constants.Streams.NON_DRM_VIDEO_ACCESS_TOKEN
        )
    }
}
