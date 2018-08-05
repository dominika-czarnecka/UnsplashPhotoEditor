import UIKit

protocol EditorViewModelProtocol {
    var photo: Photo { get set }
    var image: UIImage? { get set }
    var gradient: CAGradientLayer { get set }
}
