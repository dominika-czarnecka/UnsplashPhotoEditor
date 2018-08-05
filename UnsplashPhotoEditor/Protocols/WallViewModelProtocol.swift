import UIKit

protocol WallViewModelProtocol {
    weak var delegate: WallViewDelegate? { get set }
    
    var photosList: [Photo] { get set }
    var photosImages: [UIImage?] { get set }
    
    func set(_ image: UIImage?, for indexPathItem: Int)
    func image(for indexPathItem: Int) -> UIImage?
}
