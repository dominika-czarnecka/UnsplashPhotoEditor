import UIKit

final class WallView: BaseView {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: WallCollectionViewLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var noInternetConnectionLabel: UILabel = {
        let label = UILabel()
        label.text = "WallView.NoInternetConnection.Message".localized
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func configureConstraints() {
        [collectionView, noInternetConnectionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addConstraints([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            noInternetConnectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noInternetConnectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
