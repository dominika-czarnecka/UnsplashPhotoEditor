import UIKit

class Photo: Codable {
    let id: String
    let urls: PhotoUrls
    let width: CGFloat?
    let height: CGFloat?
    
    init?(_ id: String?, urls: PhotoUrls?, width: CGFloat?, height: CGFloat?) {
        guard let id = id, let photoUrls = urls else { return nil }
        self.id = id
        self.urls = photoUrls
        self.width = width
        self.height = height
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        urls = try container.decode(PhotoUrls.self, forKey: .urls)
        let widthFromServer = try container.decode(CGFloat.self, forKey: .width)
        let heightFromServer = try container.decode(CGFloat.self, forKey: .height)
        
        let scale = 1080 / widthFromServer
        
        width = 1080
        height = heightFromServer * scale
    }
    
}
