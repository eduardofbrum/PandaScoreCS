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

struct ListMatchServiceMock: ListMatchServiceProtocol {
    func getMatches() -> AnyPublisher<[Match], Error> {
        let mockMatches = [
            Match(
                id: 1, status: .running,
                scheduledAt: "2024-08-27T12:00:00Z",
                league: League(name: "League A", imageUrl: nil),
                opponents: nil,
                serie: Serie(name: "Serie A")
            ),
            Match(
                id: 2, status: .notStarted,
                scheduledAt: "2024-08-27T21:00:00Z",
                league: League(name: "League B", imageUrl: nil),
                opponents: nil,
                serie: Serie(name: "Serie B")
            ),
            Match(
                id: 3,
                status: .notStarted,
                scheduledAt: "2024-08-27T22:00:00Z",
                league: League(name: "League C", imageUrl: nil),
                opponents: nil,
                serie: Serie(name: "Serie C")
            ),
            Match(
                id: 4,
                status: .notStarted,
                scheduledAt: "2024-09-03T23:00:00Z",
                league: League(name: "League D", imageUrl: nil),
                opponents: nil,
                serie: Serie(name: "Serie D")
            )
        ]
        
        return Just(mockMatches)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
