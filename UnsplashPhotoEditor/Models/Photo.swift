import Foundation

class Photo: Codable {
    let id: String
    let urls: PhotoUrls
    let width: Int?
    let height: Int?
    
    init?(_ id: String?, urls: PhotoUrls?, width: Int?, height: Int?) {
        guard let id = id, let photoUrls = urls else { return nil }
        self.id = id
        self.urls = photoUrls
        self.width = width
        self.height = height
    }
}
