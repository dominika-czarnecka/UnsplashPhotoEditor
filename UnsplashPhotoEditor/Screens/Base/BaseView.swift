import UIKit

class BaseView: UIView {
    init() {
        super.init(frame: .zero)
        configureConstraints()
        backgroundColor = .background
    }
    
    internal func configureConstraints() {
        fatalError("You have to override this function")
    }
    
    @available(*, unavailable, message: "Please use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
