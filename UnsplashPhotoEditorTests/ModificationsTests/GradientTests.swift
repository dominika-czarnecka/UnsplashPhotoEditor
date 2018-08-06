import XCTest

@testable import UnsplashPhotoEditor

class GradientTests: XCTestCase {
    var editorViewController: EditorViewController?
    
    override func setUp() {
        super.setUp()
        editorViewController = EditorViewController(model: EditorViewModelMock())
        editorViewController?.customView.gradientView.isHidden = false
        
        editorViewController?.viewDidLoad()
        
        editorViewController?.customView.gradientView.colorsPaletteImageView.backgroundColor = UIColor(red: 0.98, green: 0.65, blue: 0.5, alpha: 1)
        editorViewController?.customView.gradientView.colorsPaletteImageView.image = nil
        
        editorViewController?.customView.layoutIfNeeded()
    }
    
    override func tearDown() {
        editorViewController = nil
        super.tearDown()
    }
    
    func testColorOfPoint() {
        let selectedPoint = CGPoint(x: 50, y: 50)
        
        let color = editorViewController!.customView.gradientView.colorsPaletteImageView.layer.colorOfPoint(point: selectedPoint)
        let trueColor = UIColor(red: 0.98, green: 0.65, blue: 0.5, alpha: 1)
        
        XCTAssertEqual(color, trueColor, "Colors should match.")
    }

}
