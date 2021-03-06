import UIKit

protocol EditorViewModelProtocol {
    var photo: Photo { get set }
    var image: UIImage? { get set }

    var gradient: CAGradientLayer { get set }
    
    var filter: CIFilter? { get set }
    var context: CIContext { get set }
    var availableFiltersNames: [String] { get set }
    var availableFilters: [String] { get set }
}
