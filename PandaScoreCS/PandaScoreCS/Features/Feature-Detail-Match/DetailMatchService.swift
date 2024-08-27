import Combine
import Foundation

protocol DetailMatchServiceProtocol {
    func getMatchPlayers(teamId: Int) -> AnyPublisher<[Player], Error>
}

class DetailMatchService: DetailMatchServiceProtocol {
    let apiClient = URLSessionAPIClient<MatchEndpoint>()
    
    init() { }
    
    func getMatchPlayers(teamId: Int) -> AnyPublisher<[Player], Error> {
        return apiClient.request(.getPlayers(teamId: teamId))
    }
}
