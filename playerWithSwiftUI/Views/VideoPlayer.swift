import SwiftUI

struct VideoPlayer: View {
    var orgCode: String
    var videoId: String
    var accessToken: String
    
    var body: some View {
        VStack {
            ZStack {
                VideoPlaybackView(orgCode: orgCode, videoId: videoId, accessToken: accessToken)
                ControlsView()
            }
            Spacer()
        }.frame(height: 240, alignment: .topLeading)
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
