import Foundation

class GetPhotosRequest: APIRequest {
    var method: RequestType = .GET
    var path: String = "photos"
    var queries: [String : String] = [:]
    var headers: [String : String] = [:]
    
    init(page: Int) {
     queries["page"] = page.description
    }
}
