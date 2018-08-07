import Foundation

class SearchPhotoRequest: APIRequest {
    var method: RequestType = .GET
    var path: String = "search/photos"
    var queries: [String : String] = [:]
    var headers: [String : String] = [:]
    
    init(page: Int, searchTest: String) {
        queries["page"] = page.description
        queries["query"] = searchTest
    }
}
