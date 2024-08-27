import Combine
import Foundation

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}

enum URLSessionAPIClientError: Error {
    case urlError
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        guard var components = urlComponents else {
            return Fail(error: APIError.invalidResponse)
                .eraseToAnyPublisher()
        }
        
        components.queryItems = endpoint.parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            return Fail(error: APIError.invalidResponse)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        let decoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
