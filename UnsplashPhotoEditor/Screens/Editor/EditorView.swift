import UIKit

final class EditorView: BaseView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
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
    
    override func configureConstraints() {
        [imageView, shareButton, cancelButton, stackView].forEach {
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
        addConstraints([
            imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: .margin),
            imageView.leftAnchor.constraint(equalTo: cancelButton.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: shareButton.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.margin)
        ])
    }
}
