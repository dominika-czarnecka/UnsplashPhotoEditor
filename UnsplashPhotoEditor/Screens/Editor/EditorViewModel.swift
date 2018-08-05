import UIKit

final class EditorViewModel: EditorViewModelProtocol {
    var photo: Photo
    var image: UIImage?
    
    init(photo: Photo) {
        self.photo = photo
    }
}
