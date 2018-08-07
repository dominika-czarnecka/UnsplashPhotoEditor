import UIKit

final class EditorViewModel: EditorViewModelProtocol {
    var photo: Photo
    var image: UIImage?
    
    var gradient = CAGradientLayer()
    
    var filter: CIFilter?
    var context: CIContext = CIContext(options:nil)
    var availableFiltersNames: [String] = ["Filter.SepiaTone.Name".localized, "Filter.ColorInvert.Name".localized, "Filter.ColorPosterize.Name".localized, "Filter.SoftLightBlendMode.Name".localized]
    var availableFilters: [String] = ["CISepiaTone", "CIColorInvert", "CIColorPosterize", "CISoftLightBlendMode"]
    
    init(photo: Photo) {
        self.photo = photo
    }
}
