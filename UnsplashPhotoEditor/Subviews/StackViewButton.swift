import UIKit

class StackViewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        layer.cornerRadius = 2
        translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            heightAnchor.constraint(equalToConstant: .buttonHeight)
        ])
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            titleLabel!.leftAnchor.constraint(equalTo: leftAnchor, constant: .minimumMargin),
            titleLabel!.topAnchor.constraint(equalTo: topAnchor, constant: .minimumMargin),
            titleLabel!.rightAnchor.constraint(equalTo: rightAnchor, constant: -.minimumMargin),
            titleLabel!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.minimumMargin)
        ])
    }
    
    @available(*, unavailable, message: "Use init(frame: CGRect)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
