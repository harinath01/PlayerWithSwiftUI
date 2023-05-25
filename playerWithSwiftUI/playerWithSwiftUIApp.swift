import SwiftUI
import AVKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            debugPrint("Setting category to AVAudioSession.Category.playback failed.")
        }
        return true
    }
}


@main
struct main: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
