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
}
