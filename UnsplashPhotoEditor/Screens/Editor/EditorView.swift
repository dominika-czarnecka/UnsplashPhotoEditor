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
    
    let gradientView = GradientView()
    let filterView = FilterView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    let gradientButton: StackViewButton = {
        let button = StackViewButton()
        button.setTitle("EditorView.GradientButton.Title".localized, for: .normal)
        return button
    }()
    
    let filterButton: StackViewButton = {
        let button = StackViewButton()
        button.setTitle("EditorView.FilterButton.Title".localized, for: .normal)
        return button
    }()
    
    var imageViewTopConstraint: NSLayoutConstraint?
    var imageViewLeftConstraint: NSLayoutConstraint?
    
    override func configureConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        
        [gradientButton, filterButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        stackView.addArrangedSubview(gradientButton)
        stackView.addArrangedSubview(filterButton)
        
        [scrollView, stackView, gradientView, filterView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        gradientView.isHidden = true
        filterView.isHidden = true
        
        addConstraints([
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.margin),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: .margin),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -.margin),
            stackView.heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        imageViewLeftConstraint = imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
        
        addConstraints([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .margin),
            scrollView.leftAnchor.constraint(equalTo:  safeAreaLayoutGuide.leftAnchor, constant: .margin),
            scrollView.rightAnchor.constraint(equalTo:  safeAreaLayoutGuide.rightAnchor, constant: -.margin),
            scrollView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -.margin)
        ])
        addConstraints([
            imageViewTopConstraint!,
            imageViewLeftConstraint!,
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
        ])
        
        addConstraints([
            gradientView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            gradientView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -.minimumMargin)
        ])
        addConstraints([
            filterView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            filterView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -.minimumMargin)
        ])
    }
}
