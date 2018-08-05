import Foundation
import UIKit

final class EditorViewController: UIViewController {
    private let viewModel: EditorViewModelProtocol
    private let rawImageUrl: URL
    
    var customView: EditorView {
        get { return view as! EditorView }
    }
    
    override func loadView() {
        view = EditorView()
    }
    
    init(_ model: EditorViewModelProtocol, rawImageUrl: URL) {
        self.rawImageUrl = rawImageUrl
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(_ model: EditorViewModelProtocol)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
