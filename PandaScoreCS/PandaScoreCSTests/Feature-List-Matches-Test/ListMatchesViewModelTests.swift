import Combine
@testable import PandaScoreCS
import XCTest

final class ListMatchesViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func test_fetch_whenServiceIsFailure_shouldSetStateToError() {
        // Given
        let listMatchServiceStub = ListMatchServiceStub()
        let expectedError = APIError.invalidResponse
        listMatchServiceStub.getMatchesResultToBeReturned = .failure(expectedError)
        let sut = ListMatchViewModel(service: listMatchServiceStub)
        let expectedState: ListState = .error
        
        let loadExpectation = expectation(description: "State should be set to error")
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
    
    func test_fetch_whenServiceIsSuccessful_shouldSetStateToLoaded() {
        // Given
        let listMatchServiceStub = ListMatchServiceStub()
        let stubbedMatches: [Match] = [
            .fixture(),
            .fixture(),
            .fixture()
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
