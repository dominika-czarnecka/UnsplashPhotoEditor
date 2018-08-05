import UIKit

class WallCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let activitiIndicatorView: UIActivityIndicatorView = {
       let activitiIndicator = UIActivityIndicatorView()
        activitiIndicator.color = .background
        return activitiIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    @available(*, unavailable, message: "Please use init(frame: CGRect) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        [imageView, activitiIndicatorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addConstraints([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        addConstraints([
            activitiIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activitiIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activitiIndicatorView.stopAnimating()
    }
}
