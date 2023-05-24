import Foundation
import Alamofire

class StreamsAPIClient: BaseAPIClient {
    class override var VIDEO_DETAIL_API: String {  return "https://app.tpstreams.com/api/v1/%@/assets/%@/?access_token=%@"
    }

    override class func parseVideoDetails(data: Data) throws -> VideoDetails {
        guard let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let video = responseDict["video"] as? [String: Any],
              let videoId = responseDict["id"] as? String,
              let title = responseDict["title"] as? String,
              let playbackURL = video["playback_url"] as? String,
              let transcodingStatus = video["status"] as? String else {
            throw NSError(domain: "InvalidResponseError", code: 0)
        }

        return VideoDetails(videoId: videoId,
                            title: title,
                            playbackURL: playbackURL,
                            transcodingStatus: transcodingStatus)
    }
}
