import XCTest

@testable import UnsplashPhotoEditor

class WallViewControllerTests: XCTestCase {
    var wallViewController: WallViewController?
    
    override func setUp() {
        super.setUp()
        wallViewController = WallViewController(WallViewModelMock())
        wallViewController?.customView.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        wallViewController?.customView.layoutIfNeeded()
    }
    
    override func tearDown() {
        wallViewController = nil
        super.tearDown()
    }
    
    //Check if wallViewController properly calculate UICollectionViewCell's height
    func testCollectionViewCellsHeight() {
        let cell0Height = Int(wallViewController?.customView.collectionView.cellForItem(at: IndexPath(item: 0, section: 0 ))?.frame.height ?? 0)
        let cell1Height = Int(wallViewController?.customView.collectionView.cellForItem(at: IndexPath(item: 1, section: 0 ))?.frame.height ?? 0)
        let cell2Height = Int(wallViewController?.customView.collectionView.cellForItem(at: IndexPath(item: 2, section: 0 ))?.frame.height ?? 0)
        XCTAssertEqual(cell0Height, 241, "Cell 0 height is not properly calculated")
        XCTAssertEqual(cell1Height, 217, "Cell 1 height is not properly calculated")
        XCTAssertEqual(cell2Height, 72, "Cell 2 height is not properly calculated")
    }
}
