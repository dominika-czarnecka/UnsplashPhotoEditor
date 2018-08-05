import XCTest

@testable import UnsplashPhotoEditor

class PhotosTests: XCTestCase {
    
    //Check if Photo will initialize without id
    func testInitializePhotoWithoutID() {
        let photo = Photo(nil, urls: PhotoUrls(raw: "raw", thumb: "thumb"), width: 200, height: 200)
        XCTAssertNil(photo, "It shouldn't be possible to initialize Photo without id")
    }
    
    //Check if Photo will initialize without urls
    func testInitializePhotoWithoutUrls() {
        let photo = Photo("0", urls: nil, width: 200, height: 200)
        XCTAssertNil(photo, "It shouldn't be possible to initialize Photo without PhotoUrls")
    }
}
