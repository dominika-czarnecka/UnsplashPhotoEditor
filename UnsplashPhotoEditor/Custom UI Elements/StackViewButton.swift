import UIKit

class StackViewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let titleLabel = titleLabel else { return }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            heightAnchor.constraint(equalToConstant: .buttonHeight),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @available(*, unavailable, message: "Use init(frame: CGRect)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
