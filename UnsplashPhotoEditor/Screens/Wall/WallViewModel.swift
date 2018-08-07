import UIKit

protocol WallViewDelegate: AnyObject {
    func reloadCell(indexPath: IndexPath)
    func getPhotoFromServer(urlString: String, for indexPathItem: Int)
}

class WallViewModel: WallViewModelProtocol {
    weak var delegate: WallViewDelegate?
    
    var photosPerPage: Int = 10
    var currentPage: Int = 0
    
    var photosList: [Photo] = [] {
        didSet {
            photosImages.append(contentsOf: Array(repeating: nil, count: photosList.count - oldValue.count))
            photosList.enumerated().forEach { (index, photo) in
                if index >= oldValue.count || oldValue[index].id != photo.id {
                    delegate?.getPhotoFromServer(urlString: photo.urls.thumb, for: index)
                }
            }
        }
    }
    
    var photosImages: [UIImage?] = []
    
    func set(_ image: UIImage?, for indexPathItem: Int) {
        photosImages[indexPathItem] = image
        delegate?.reloadCell(indexPath: IndexPath(item: indexPathItem, section: 0))
    }
    
    func image(for indexPathItem: Int) -> UIImage? {
        if indexPathItem < photosImages.count {
            return photosImages[indexPathItem]
        } else {
            return nil
        }
    }
}
