import Foundation

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var queries: [String: String] { get }
    var headers: [String: String] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = queries.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept") 
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        //TODO: Remove before commit!!!
        let accessKey = "be82fe8fbf6e772cdeee68373d4048f735db2332afe8b8700a04d6a75e2c572c"
        request.addValue(accessKey, forHTTPHeaderField: "Authorization")
        return request
    }
}
