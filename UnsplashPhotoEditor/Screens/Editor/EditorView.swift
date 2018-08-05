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
    
    let colorsPaletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "colorsPallette")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    let gradientButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "gradient"), for: .normal)
        return button
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
        
        [gradientButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        stackView.addArrangedSubview(gradientButton)
        
        [scrollView, shareButton, cancelButton, stackView, colorsPaletteImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
     
        colorsPaletteImageView.isHidden = true
        
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
            stackView.leftAnchor.constraint(equalTo: cancelButton.rightAnchor, constant: .minimumMargin),
            stackView.rightAnchor.constraint(equalTo: shareButton.leftAnchor, constant: -.minimumMargin),
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
        
        addConstraints([
            gradientButton.heightAnchor.constraint(equalToConstant: .buttonHeight),
            gradientButton.widthAnchor.constraint(equalTo: gradientButton.heightAnchor)
        ])
        addConstraints([
            colorsPaletteImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            colorsPaletteImageView.heightAnchor.constraint(equalToConstant: 200),
            colorsPaletteImageView.widthAnchor.constraint(equalToConstant: 200),
            colorsPaletteImageView.topAnchor.constraint(equalTo: gradientButton.bottomAnchor, constant: .minimumMargin)
        ])
    }
}
