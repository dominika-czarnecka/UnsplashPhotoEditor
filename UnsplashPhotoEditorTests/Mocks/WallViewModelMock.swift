import UIKit

@testable import UnsplashPhotoEditor

class WallViewModelMock: WallViewModelProtocol {
    weak var delegate: WallViewDelegate?

    var photosList: [Photo] = {
        return [
            Photo("0", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 300, height: 500),
            Photo("1", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 200, height: 300),
            Photo("2", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 400, height: 200)
        ].compactMap { $0 }
    }()
 
    var photosImages: [UIImage?] = Array(repeating: nil, count: 3)
    
    func set(_ image: UIImage?, for indexPathItem: Int) {
        photosImages[indexPathItem] = image
    }
    
    func image(for indexPathItem: Int) -> UIImage? {
        if indexPathItem < photosImages.count {
            return photosImages[indexPathItem]
        } else {
            return nil
        }
    }
}
