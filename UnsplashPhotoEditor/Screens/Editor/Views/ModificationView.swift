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
        setupConstraints()
    }
    @available(*, unavailable, message: "Use init(frame: CGRect) insted")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
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
