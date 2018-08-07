import Foundation
import UIKit

final class WallViewController: UIViewController {
    private var viewModel: WallViewModelProtocol
    private var timer: Timer?
    
    var customView: WallView {
        get { return view as! WallView }
    }
    
    override func loadView() {
        view = WallView()
    }
    
    init(_ model: WallViewModelProtocol) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(_ model: WallViewModelProtocol) insted")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        customView.collectionView.register(WallCollectionViewCell.self, forCellWithReuseIdentifier: "WallCell")
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        (customView.collectionView.collectionViewLayout as? WallCollectionViewLayout)?.delegate = self
        
        viewModel.delegate = self
        
        getNextpageOfPhotosListFromServer()
    }
    
    @objc func getNextpageOfPhotosListFromServer() {
        if Reachability.isConnectedToNetwork() {
            customView.noInternetConnectionLabel.isHidden = true
            timer?.invalidate()
            viewModel.currentPage += 1
            
            ApiManager().send(GetPhotosRequest(page: viewModel.currentPage), for: [Photo].self) { [weak self] (photos, error) in
                guard error == nil else { return }
                
                DispatchQueue.main.async {
                    guard let strongSelf = self, let photos = photos else { return }
                    strongSelf.viewModel.photosList.append(contentsOf: photos)
                    self?.customView.collectionView.reloadData()
                }
            }
        } else {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getNextpageOfPhotosListFromServer), userInfo: nil, repeats: false)
            customView.noInternetConnectionLabel.isHidden = false
        }
    }
}

extension WallViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosList.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallCell", for: indexPath) as? WallCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == (viewModel.photosList.count - 3) {
            getNextpageOfPhotosListFromServer()
        }
        
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

extension WallViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = viewModel.photosList[indexPath.item]
        navigationController?.pushViewController(EditorViewController(model: EditorViewModel(photo: photo)), animated: true)
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
            guard error == nil else { return }
            
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
