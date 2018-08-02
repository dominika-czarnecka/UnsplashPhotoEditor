import UIKit

class BaseViewController<TView: UIView> : UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var customView: TView {
        get { return view as! TView }
    }
    
    override func loadView() {
        view = TView()
    }
    
    @available(*, unavailable, message: "Please use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
