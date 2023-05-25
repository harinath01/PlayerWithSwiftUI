import SwiftUI

struct VideoPlayer: View {
    var orgCode: String
    var videoId: String
    var accessToken: String
    
    var body: some View {
        ZStack {
            VideoPlaybackView(orgCode: orgCode, videoId: videoId, accessToken: accessToken)
            ControlsView()
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
