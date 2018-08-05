import UIKit

final class EditorView: BaseView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 100
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    let cancelButton: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return button
    }()
    
    let shareButton: UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        return button
    }()
    
    var imageViewTopConstraint: NSLayoutConstraint?
    var imageViewLeftConstraint: NSLayoutConstraint?
    
    override func configureConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        
        [scrollView, shareButton, cancelButton, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
     
        addConstraints([
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            shareButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -.margin),
            shareButton.widthAnchor.constraint(equalToConstant: .buttonHeight),
            shareButton.heightAnchor.constraint(equalToConstant: .buttonHeight)
            ])
        addConstraints([
            cancelButton.topAnchor.constraint(equalTo: shareButton.topAnchor),
            cancelButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: .margin),
            cancelButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
       addConstraints([
            stackView.topAnchor.constraint(equalTo: shareButton.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewLeftConstraint = imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
        
        addConstraints([
            scrollView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: .margin),
            scrollView.leftAnchor.constraint(equalTo: cancelButton.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: shareButton.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.margin)
        ])
        addConstraints([
            imageViewTopConstraint!,
            imageViewLeftConstraint!,
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
        ])
    }
}
