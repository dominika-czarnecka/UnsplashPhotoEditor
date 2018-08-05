import Foundation

struct PhotoUrls: Codable {
    var raw: String
    var thumb: String
    
    init?(raw: String?, thumb: String?) {
        guard let raw = raw, let thumb = thumb else { return nil }
        self.raw = raw
        self.thumb = thumb
    }
}
