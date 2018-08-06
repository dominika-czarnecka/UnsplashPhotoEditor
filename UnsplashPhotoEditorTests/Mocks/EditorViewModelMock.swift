import UIKit

@testable import UnsplashPhotoEditor

final class EditorViewModelMock: EditorViewModelProtocol {
    var colorpaletteimage: UIImage? = #imageLiteral(resourceName: "colorsPallette")
    var photo: Photo = Photo("0", urls: PhotoUrls(raw: "", thumb: ""), width: 300, height: 500)!
    var image: UIImage?
    var gradient = CAGradientLayer()
}
