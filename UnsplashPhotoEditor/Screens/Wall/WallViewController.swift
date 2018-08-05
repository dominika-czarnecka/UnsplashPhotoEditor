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
        viewModel.delegate = self
        getPhotosListFromServer()
    }
    
    private func getPhotosListFromServer() {
        ApiManager().send(GetPhotosRequest(), for: [Photo].self) { [weak self] (photos, error) in
            guard error == nil else {
                print(error!)
                return
            }
            print(photos?.count)
            self?.viewModel.photosList = photos ?? []
            DispatchQueue.main.async {
                self?.customView.collectionView.reloadData()
            }
        }
    }
}

extension WallViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosList.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallCell", for: indexPath) as? WallCollectionViewCell else { return UICollectionViewCell() }
        
        if let image = viewModel.image(for: indexPath.item) {
            cell.imageView.image = image
        } else {
            cell.activitiIndicatorView.startAnimating()
        }
        
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
        let photoHeight: CGFloat = CGFloat(viewModel.photosList[indexPath.item].height ?? 0)
        let photoWeight: CGFloat = CGFloat(viewModel.photosList[indexPath.item].width ?? 0)
        return photoHeight * cellWidth / photoWeight
    }
}

extension WallViewController: WallViewDelegate {
    func getPhotoFromServer(urlString: String, for indexPathItem: Int) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let strongSelf = self, let data = data else { return }
                let image = UIImage(data: data)
                strongSelf.viewModel.set(image, for: indexPathItem)
            })
        }).resume()
    }
    
    func reloadCell(indexPath: IndexPath) {
        guard let cell = customView.collectionView.cellForItem(at: indexPath) as? WallCollectionViewCell,
        customView.collectionView.visibleCells.contains(cell),
        let image = viewModel.image(for: indexPath.item) else { return }
    
        cell.activitiIndicatorView.stopAnimating()
        cell.imageView.image = image
    }
}
