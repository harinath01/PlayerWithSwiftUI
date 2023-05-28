import SwiftUI
import AVKit

struct VideoPlayer: View {
    @StateObject var viewModel: VideoPlayerViewModel
    
    init(orgCode: String, videoId: String, accessToken: String) {
        _viewModel = StateObject(wrappedValue: VideoPlayerViewModel(
            orgCode: orgCode,
            videoId: videoId,
            accessToken: accessToken
        ))
    }

    var body: some View {
        ZStack {
            if let player = viewModel.player {
                VideoPlaybackView(player: player)
                ControlsView(
                    videoDuration: viewModel.videoDuration,
                    currentTime: viewModel.currentTime ?? 0.0,
                    playerStatus: viewModel.playerStatus,
                    controlsDelegate: viewModel
                )
            }
        }
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
