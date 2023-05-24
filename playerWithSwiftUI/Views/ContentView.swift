import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VideoPlayer(
                orgCode: Constants.Streams.ORG_CODE,
                videoId: Constants.Streams.NON_DRM_VIDEO_ID,
                accessToken: Constants.Streams.NON_DRM_VIDEO_ACCESS_TOKEN
            ).frame(height: 240, alignment: .topLeading)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
