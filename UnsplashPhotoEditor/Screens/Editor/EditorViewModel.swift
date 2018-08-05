import UIKit

final class EditorViewModel: EditorViewModelProtocol {
    var photo: Photo
    var image: UIImage?
    var gradient = CAGradientLayer()
    
    init(photo: Photo) {
        self.photo = photo
    }
}
