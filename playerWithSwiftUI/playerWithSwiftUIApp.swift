import SwiftUI
import AVKit

@main
struct main: App {
    var body: some Scene {
        WindowGroup {
            VStack{
                VideoPlayer(
                    orgCode: Constants.Streams.ORG_CODE,
                    videoId: Constants.Streams.NON_DRM_VIDEO_ID,
                    accessToken: Constants.Streams.NON_DRM_VIDEO_ACCESS_TOKEN
                ).frame(height: 240)
                Spacer()
            }
        }
    }
}
