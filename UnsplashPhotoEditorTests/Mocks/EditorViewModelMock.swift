import UIKit

@testable import UnsplashPhotoEditor

final class EditorViewModelMock: EditorViewModelProtocol {
    var filter: CIFilter? = nil
    var context: CIContext = CIContext()
    var availableFiltersNames: [String] = []
    var availableFilters: [String] = []
    
    var colorpaletteimage: UIImage? = #imageLiteral(resourceName: "colorsPallette")
    var photo: Photo = Photo("0", urls: PhotoUrls(regular: "", thumb: ""), width: 300, height: 500)!
    var image: UIImage?
    var gradient = CAGradientLayer()
}
