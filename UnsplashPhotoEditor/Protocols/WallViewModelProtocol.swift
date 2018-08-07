import UIKit

protocol WallViewModelProtocol {
    weak var delegate: WallViewDelegate? { get set }
    
    var searchText: String? { get set }
    var photosPerPage: Int { get }
    var currentPage: Int { get set }
    var photosList: [Photo] { get set }
    var photosImages: [UIImage?] { get set }
    
    func set(_ image: UIImage?, for indexPathItem: Int)
    func image(for indexPathItem: Int) -> UIImage?
    func resetPages()
}
