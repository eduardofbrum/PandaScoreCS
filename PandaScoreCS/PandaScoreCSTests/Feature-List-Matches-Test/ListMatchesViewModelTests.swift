import Combine
@testable import PandaScoreCS
import XCTest

final class ListMatchesViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func test_fetch_whenServiceIsSuccessful_shouldSetStateToLoaded() {
        // Given
        let listMatchServiceStub = ListMatchServiceStub()
        let stubbedMatches: [Match] = [
            .init(
                id: 1,
                status: .running,
                scheduledAt: "",
                league: .init(name: "League 1", imageUrl: "mock"),
                opponents: [],
                serie: .init(name: "Serie 1")
            ),
            .init(
                id: 2,
                status: .running,
                scheduledAt: "",
                league: .init(name: "League 2", imageUrl: "mock"),
                opponents: [],
                serie: .init(name: "Serie 2")
            )
        ]
        listMatchServiceStub.getMatchesResultToBeReturned = .success(stubbedMatches)
        let sut = ListMatchViewModel(service: listMatchServiceStub)
        let expectedState: ListState = .loaded(stubbedMatches)
        
        let loadExpectation = expectation(description: "State should be set to loaded")
        sut.$listState
            .dropFirst()
            .sink { _ in
                loadExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        //When
        sut.fetchMatches()
        wait(for: [loadExpectation], timeout: 1.0)
        
        //Then
        XCTAssertEqual(sut.listState, expectedState)
    }
}
