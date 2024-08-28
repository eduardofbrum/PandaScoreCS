import Combine
import Foundation

protocol ListMatchServiceProtocol {
    func getMatches(page: String) -> AnyPublisher<[Match], Error>
}

class ListMatchService: ListMatchServiceProtocol {
    let apiClient = URLSessionAPIClient<MatchEndpoint>()
    
    func getMatches(page: String) -> AnyPublisher<[Match], Error> {
        return apiClient.request(.getMatches(page: page))
    }
}

final class ListMatchServiceStub: ListMatchServiceProtocol {
    var getMatchesResultToBeReturned: Result<[Match], Error> = .success([])
    
    func getMatches(page: String) -> AnyPublisher<[Match], Error> {
        switch getMatchesResultToBeReturned {
        case .success(let matches):
            return Just(matches)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
