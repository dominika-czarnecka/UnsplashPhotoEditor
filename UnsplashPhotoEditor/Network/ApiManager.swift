import Foundation

class ApiManager {
    private let baseURL = URL(string: "https://api.unsplash.com")!
    
    func send<T: Codable>(_ apiRequest: APIRequest, for: T.Type = T.self, completion: @escaping (T?, Error?) -> Void ) {
        let request = apiRequest.request(with: baseURL)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            do {
                let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                completion(model, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
