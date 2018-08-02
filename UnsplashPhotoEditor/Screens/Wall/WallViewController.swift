import Foundation
import UIKit

final class WallViewController: BaseViewController<WallView> {
    private let viewModel = WallViewModel()
    
    override func viewDidLoad() {
        ApiManager().send(GetPhotosRequest(), for: [Photo].self) { [weak self] (photos, error) in
            guard error == nil else {
                print(error!)
                return
            }
            self?.viewModel.photos = photos
        }
    }
}
