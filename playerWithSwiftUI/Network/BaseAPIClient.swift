import Foundation
import Alamofire

class BaseAPIClient {
    class var VIDEO_DETAIL_API: String {
        fatalError("videoDetailAPI must be implemented by subclasses.")
    }

    static func fetchVideo(orgCode: String, videoId: String, accessToken: String, completion: @escaping (VideoDetails?, Error?) -> Void) {
        let url = URL(string: String(format: VIDEO_DETAIL_API, orgCode, videoId, accessToken))!

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let videoDetails = try parseVideoDetails(data: data)
                    completion(videoDetails, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    class func parseVideoDetails(data: Data) throws -> VideoDetails {
        fatalError("parseVideoDetails(data:) must be overridden by subclasses.")
    }
}
