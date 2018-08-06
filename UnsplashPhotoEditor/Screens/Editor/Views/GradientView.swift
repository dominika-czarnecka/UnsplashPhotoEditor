import UIKit

final class GradientView: ModificationView {
    let colorsPaletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "colorsPallette")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        titleLabel.text = "GradientView.Title".localized
        
        [colorsPaletteImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addConstraints([
            colorsPaletteImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .minimumMargin),
            colorsPaletteImageView.leftAnchor.constraint(equalTo: leftAnchor),
            colorsPaletteImageView.rightAnchor.constraint(equalTo: rightAnchor),
            colorsPaletteImageView.heightAnchor.constraint(equalToConstant: 150),
            colorsPaletteImageView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -.minimumMargin)
        ])
    }
}
