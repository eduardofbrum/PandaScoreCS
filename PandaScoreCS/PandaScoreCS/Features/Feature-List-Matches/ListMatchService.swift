import Combine
import Foundation

protocol ListMatchServiceProtocol {
    func getMatches() -> AnyPublisher<[Match], Error>
}

class ListMatchService: ListMatchServiceProtocol {
    let apiClient = URLSessionAPIClient<MatchEndpoint>()
    
    func getMatches() -> AnyPublisher<[Match], Error> {
        return apiClient.request(.getMatches)
    }
}
