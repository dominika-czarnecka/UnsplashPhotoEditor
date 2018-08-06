import Foundation

struct PhotoUrls: Codable {
    var regular: String
    var thumb: String
    
    init?(regular: String?, thumb: String?) {
        guard let regular = regular, let thumb = thumb else { return nil }
        self.regular = regular
        self.thumb = thumb
    }
}
