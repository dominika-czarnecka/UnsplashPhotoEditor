import Foundation
import UIKit

final class EditorViewController: UIViewController {
    private var viewModel: EditorViewModelProtocol
    
    var customView: EditorView {
        get { return view as! EditorView }
    }
    
    override func loadView() {
        view = EditorView()
    }
    
    init(model: EditorViewModelProtocol) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
        getPhotoFromServer()
        customView.scrollView.delegate = self
        customView.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        let tapGestureRecognized = UITapGestureRecognizer(target: self, action: #selector(zoomToDefaultScale))
        tapGestureRecognized.numberOfTapsRequired = 2
        customView.scrollView.addGestureRecognizer(tapGestureRecognized)
    }
    
    @available(*, unavailable, message: "Use init(_ model: EditorViewModelProtocol, rawImageUrl: URL)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPhotoFromServer() {
        guard let url = URL(string: viewModel.photo.urls.raw) else {
            //TODO: Complection with alert?
            dismiss(animated: true, completion: nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let strongSelf = self, let data = data else { return }
                let image = UIImage(data: data)
                strongSelf.viewModel.image = image
                strongSelf.zoomToDefaultScale()
                strongSelf.customView.imageView.image = image
            })
        }).resume()
    }
    
    @objc func zoomToDefaultScale() {
        let widthScale = customView.scrollView.frame.width / (viewModel.photo.width ?? 0)
        let heightScale = customView.scrollView.frame.height / (viewModel.photo.height ?? 0)
        customView.scrollView.minimumZoomScale = min(widthScale, heightScale)
        customView.scrollView.setZoomScale(min(widthScale, heightScale), animated: true)
    }
    
    @objc func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension EditorViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return customView.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.size.width - (viewModel.photo.width ?? 0) * scrollView.zoomScale) * 0.5, CGFloat(0.0))
        let offsetY = max((scrollView.bounds.size.height - (viewModel.photo.height ?? 0) * scrollView.zoomScale) * 0.5, CGFloat(0.0))
        customView.imageViewTopConstraint?.constant = offsetY
        customView.imageViewLeftConstraint?.constant = offsetX
    }
}
