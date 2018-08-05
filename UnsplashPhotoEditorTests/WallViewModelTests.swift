import XCTest
@testable import UnsplashPhotoEditor

class WallViewModelTests: XCTestCase {
    var wallViewModel: WallViewModel?
    var photos: [Photo]?
    
    override func setUp() {
        super.setUp()
        wallViewModel = WallViewModel()
        photos = [
            Photo("0", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 200, height: 200),
            Photo("1", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 200, height: 200),
            Photo("2", urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 200, height: 200)
        ].compactMap { $0 }
    }
    
    override func tearDown() {
        super.tearDown()
        wallViewModel = nil
        photos = nil
    }
    
    //Check if photosImages count is equal to photosList count
    func testPhotosImagesCountEqualToPhotosListCount() {
        wallViewModel?.photosList = photos ?? []
        XCTAssertEqual(wallViewModel?.photosImages.count, wallViewModel?.photosList.count, "Count of photosImages is not equal to photosList")
    }
}
