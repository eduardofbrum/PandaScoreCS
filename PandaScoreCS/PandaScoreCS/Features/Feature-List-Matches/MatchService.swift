import Combine
import Foundation

protocol MatchServiceProtocol {
    func getMatches() -> AnyPublisher<[Match], Error>
}

class MatchService: MatchServiceProtocol {
    let apiClient = URLSessionAPIClient<MatchEndpoint>()
    
    func getMatches() -> AnyPublisher<[Match], Error> {
        return apiClient.request(.getMatches)
    }
}
