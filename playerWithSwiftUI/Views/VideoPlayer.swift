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
        GeometryReader { geometry in
            ZStack {
                if let player = viewModel.player {
                    VideoPlaybackView(player: player)
                    ControlsView(
                        videoDuration: viewModel.videoDuration,
                        currentTime: viewModel.currentTime ?? 0.0,
                        bufferedDuration: viewModel.bufferedDuration ?? 0.0,
                        playerStatus: viewModel.playerStatus,
                        isFullScreen: viewModel.isFullScreen,
                        controlsDelegate: viewModel
                    )
                } else {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
            }
            .padding(viewModel.isFullScreen ? EdgeInsets(top: 10, leading: 10, bottom: 32, trailing: 10) : EdgeInsets())
            .frame(width: viewModel.isFullScreen ? UIScreen.main.bounds.width : geometry.size.width,
                   height: viewModel.isFullScreen ? UIScreen.main.bounds.height : geometry.size.height)
            .background(Color.black)
            .edgesIgnoringSafeArea(viewModel.isFullScreen ? .all : [])
            .statusBarHidden(viewModel.isFullScreen)
        }
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
