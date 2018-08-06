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
        
        customView.scrollView.delegate = self
    }
    
    @available(*, unavailable, message: "Use init(_ model: EditorViewModelProtocol, rawImageUrl: URL)")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let doubleTapGestureRecognized = UITapGestureRecognizer(target: self, action: #selector(zoomToDefaultScale))
        doubleTapGestureRecognized.numberOfTapsRequired = 2
        customView.scrollView.addGestureRecognizer(doubleTapGestureRecognized)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideAllModificationViews))
        customView.scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        let shareBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: .plain, target: self, action: #selector(shareButtonAction))
        navigationItem.rightBarButtonItem = shareBarButton
        
        setupGradientView()
        setupFilterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getPhotoFromServer()
    }
    
    func getPhotoFromServer() {
        guard let url = URL(string: viewModel.photo.urls.regular) else { return }
        
        customView.activitiIndicatorView.startAnimating()
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) -> Void in
            if error != nil {
                print(error)
                self?.customView.activitiIndicatorView.stopAnimating()
                return
            }
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let strongSelf = self, let data = data else { return }
                let image = UIImage(data: data)
                strongSelf.zoomToDefaultScale()
                strongSelf.viewModel.image = image
                strongSelf.customView.imageView.image = image
                strongSelf.customView.activitiIndicatorView.stopAnimating()
            })
        }).resume()
    }
    
    private func setupGradientView() {
        let colorPaletteTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorPaletteTapAction))
        customView.gradientView.colorsPaletteImageView.addGestureRecognizer(colorPaletteTapGestureRecognizer)
        
        let gradientViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(moveGradientView))
        customView.gradientView.addGestureRecognizer(gradientViewPanGesture)
        
        customView.gradientView.clearButton.addTarget(self, action: #selector(gradientClearButtonAction), for: .touchUpInside)
        customView.gradientButton.addTarget(self, action: #selector(gradientButtonAction), for: .touchUpInside)
    }
    
    private func setupFilterView() {
        customView.filterView.tableView.delegate = self
        customView.filterView.tableView.dataSource = self
        customView.filterView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterCell")
        
        let filterViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(moveFilterView))
        customView.filterView.addGestureRecognizer(filterViewPanGesture)
        
        customView.filterView.clearButton.addTarget(self, action: #selector(filterClearButtonAction), for: .touchUpInside)
        customView.filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
    }
    
    @objc func zoomToDefaultScale() {
        let widthScale = customView.scrollView.frame.width / (viewModel.photo.width ?? 0)
        let heightScale = customView.scrollView.frame.height / (viewModel.photo.height ?? 0)
        customView.scrollView.minimumZoomScale = min(widthScale, heightScale)
        customView.scrollView.setZoomScale(min(widthScale, heightScale), animated: false)
    }
    
    @objc func hideAllModificationViews() {
        customView.gradientView.isHidden = true
        customView.filterView.isHidden = true
    }
    
    @objc func moveGradientView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func moveFilterView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func gradientButtonAction() {
        customView.gradientView.isHidden = !customView.gradientView.isHidden
    }
    
    @objc func colorPaletteTapAction(_ sender: UITapGestureRecognizer) {
        let selectedPoint = sender.location(in: customView.gradientView.colorsPaletteImageView)
        let color = customView.gradientView.colorsPaletteImageView.layer.colorOfPoint(point: selectedPoint)
        let scale = customView.scrollView.zoomScale

        viewModel.gradient.frame = CGRect(origin: customView.imageView.frame.origin, size: CGSize(width: customView.imageView.frame.width / scale, height: customView.imageView.frame.height / scale))
        viewModel.gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        customView.imageView.layer.addSublayer(viewModel.gradient)
    }
    
    @objc func gradientClearButtonAction() {
        viewModel.gradient.removeFromSuperlayer()
    }
    
    @objc func filterButtonAction() {
        customView.filterView.isHidden = !customView.filterView.isHidden
    }
    
    @objc func filterClearButtonAction() {
        customView.imageView.image = viewModel.image
    }
    
    @objc func shareButtonAction() {
        UIGraphicsBeginImageContext(customView.imageView.bounds.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        customView.imageView.layer.render(in: currentContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()

        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
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

extension EditorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.avaluableFiltersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.textLabel?.text = viewModel.avaluableFiltersNames[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let image = viewModel.image else { return }
        let beginImage = CIImage(image: image)
        
        let filter = CIFilter(name: viewModel.avaluableFilters[indexPath.row])
        filter!.setValue(beginImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter!.outputImage,
            let cgimg = viewModel.context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        customView.imageView.image = UIImage(cgImage: cgimg)
    }
}
