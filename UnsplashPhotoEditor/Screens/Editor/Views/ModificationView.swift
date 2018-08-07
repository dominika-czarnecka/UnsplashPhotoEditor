import UIKit

class ModificationView: UIView {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gradient.ClearButton.Title".localized, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .background
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    @available(*, unavailable, message: "Use init(frame: CGRect) insted")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addConstraint(widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5))
        
        [titleLabel, clearButton].forEach ({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
        
        addConstraints([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: .buttonHeight),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addConstraints([
            clearButton.heightAnchor.constraint(equalToConstant: .buttonHeight),
            clearButton.widthAnchor.constraint(equalTo: widthAnchor),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
