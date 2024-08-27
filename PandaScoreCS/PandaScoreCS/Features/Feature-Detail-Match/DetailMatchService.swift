import Combine
import Foundation

protocol DetailMatchServiceProtocol {
    func getMatchPlayers(teamId: Int) -> AnyPublisher<[Player], Error>
}

class DetailMatchService: DetailMatchServiceProtocol {
    let apiClient = URLSessionAPIClient<MatchEndpoint>()
    
    func getMatchPlayers(teamId: Int) -> AnyPublisher<[Player], Error> {
        return apiClient.request(.getPlayers(teamId: teamId))
    }
}

final class DetailMatchServiceStub: DetailMatchServiceProtocol {
    var getPlayerResultToBeReturned: Result<[Player], Error> = .success([])
    
    func getMatchPlayers(teamId: Int) -> AnyPublisher<[Player], Error> {
        switch getPlayerResultToBeReturned {
        case .success(let players):
            return Just(players)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
