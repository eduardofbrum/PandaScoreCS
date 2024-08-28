import Combine
import Foundation

enum ListState: Equatable {    
    case loading
    case loaded
    case error
}

public class ListMatchViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let service: ListMatchServiceProtocol
    
    @Published var listState: ListState = .loading
    @Published var matches: [Match] = []
    @Published var isLoadingNextPage: Bool = false
    var page: Int = 1
    var limitPage: Int = 10
    
    init(service: ListMatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatches(isRefresh: Bool = false) {
        if isRefresh {
            page = 1
            limitPage = 10
        }
        
        guard page == 1 else { return }
        
        service.getMatches(page: "\(page)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.listState = .error
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] data in
                let matches = self?.sortMatches(data)
                guard let matches = matches else { return }
                self?.listState = .loaded
                self?.matches = matches
            }).store(in: &cancellables)
    }
    
    func fetchNextPage(_ offset: Int) {
        guard isLoadingNextPage == false else { return }
        guard offset == (limitPage - 1) else { return }
        
        isLoadingNextPage = true
        page += 1
        limitPage += 10
        
        service.getMatches(page: "\(page)")
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.listState = .error
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] data in
                let matches = self?.sortMatches(data)
                guard let matches = matches else { return }
                self?.matches.append(contentsOf: matches)
                self?.isLoadingNextPage = false
            }).store(in: &cancellables)
    }
    
    func getMatchDate(status: MatchStatus, date: String) -> String {
        switch status {
        case .running:
            return "AGORA"
        case .finished:
            return "FINALIZADO"
        default:
            return formatMatchDate(dateString: date, fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        }
    }
    
    func sortMatches(_ matches: [Match]) -> [Match] {
        return matches.sorted { match1, match2 in
            if match1.status == .running && match2.status != .running {
                return true
            } else if match1.status != .running && match2.status == .running {
                return false
            }
            
            if match1.status == .finished && match2.status != .finished {
                return true
            } else if match1.status != .finished && match2.status == .finished {
                return false
            }
            
            return match1.scheduledAt ?? "3024-07-17T07:05:16Z" < match2.scheduledAt ?? "3024-07-17T07:05:16Z"
        }
    }
}
