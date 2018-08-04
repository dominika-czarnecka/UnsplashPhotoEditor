import Foundation
import UIKit

final class WallViewController: UIViewController {
    private let viewModel = WallViewModel()

    var customView: WallView {
        get { return view as! WallView }
    }
    
    override func loadView() {
        view = WallView()
    }
    
    override func viewDidLoad() {
        customView.collectionView.register(WallCollectionViewCell.self, forCellWithReuseIdentifier: "WallCell")
        
        customView.collectionView.dataSource = self
        if let layout = customView.collectionView.collectionViewLayout as? WallCollectionViewLayout {
            layout.delegate = self
        }
        
        getPhotosListFromServer()
    }
    
    private func getPhotosListFromServer() {
        ApiManager().send(GetPhotosRequest(), for: [Photo].self) { [weak self] (photos, error) in
            guard error == nil else {
                print(error!)
                return
            }
            self?.viewModel.photos = photos ?? []
            DispatchQueue.main.async {
                self?.customView.collectionView.reloadData()
            }
        }
    }
}

extension WallViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallCell", for: indexPath) as? WallCollectionViewCell,
        let url = viewModel.photos[indexPath.item].urls.thumb else { return UICollectionViewCell() }
        cell.imageView.imageFromServerURL(urlString: url)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension WallViewController: WallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        let photoHeight: CGFloat = CGFloat(viewModel.photos[indexPath.item].height ?? 0)
        let photoWeight: CGFloat = CGFloat(viewModel.photos[indexPath.item].width ?? 0)
        return photoHeight * cellWidth / photoWeight
    }
}
