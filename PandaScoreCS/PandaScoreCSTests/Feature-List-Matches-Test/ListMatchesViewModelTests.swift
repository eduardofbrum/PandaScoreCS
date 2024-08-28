import Combine
@testable import PandaScoreCS
import XCTest

final class ListMatchesViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func test_fetchMatches_whenServiceIsFailure_shouldSetStateToError() {
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
    
    func test_fetchMatches_whenServiceIsSuccessful_shouldSetStateToLoaded() {
        // Given
        let listMatchServiceStub = ListMatchServiceStub()
        let stubbedMatches: [Match] = [
            .fixture(),
            .fixture(),
            .fixture()
        ]
        listMatchServiceStub.getMatchesResultToBeReturned = .success(stubbedMatches)
        let sut = ListMatchViewModel(service: listMatchServiceStub)
        let expectedState: ListState = .loaded
        
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
    
    func test_fetchMatches_whenServiceIsSuccessful_shouldSetMatches() {
        // Given
        let listMatchServiceStub = ListMatchServiceStub()
        let stubbedMatches: [Match] = [
            .fixture(),
            .fixture(),
            .fixture()
        ]
        listMatchServiceStub.getMatchesResultToBeReturned = .success(stubbedMatches)
        let sut = ListMatchViewModel(service: listMatchServiceStub)
        let expectedMatches: [Match] = stubbedMatches
        
        let loadExpectation = expectation(description: "Matchs should be set")
        sut.$matches
            .dropFirst()
            .sink { _ in
                loadExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        //When
        sut.fetchMatches()
        wait(for: [loadExpectation], timeout: 1.0)
        
        //Then
        XCTAssertEqual(sut.matches, expectedMatches)
    }
    
    func test_fetchNextPage_whenServiceSucceeds_shouldAppendMatchesAndResetLoading() {
        // Given
        let serviceStub = ListMatchServiceStub()
        let initialMatches: [Match] = [.fixture(id: 1)]
        let newMatches: [Match] = [.fixture(id: 2), .fixture(id: 3)]
        serviceStub.getMatchesResultToBeReturned = .success(newMatches)
        
        let sut = ListMatchViewModel(service: serviceStub)
        sut.matches = initialMatches
        sut.isLoadingNextPage = false
        sut.page = 1
        sut.limitPage = 10
        
        let expectation = expectation(description: "Should append new matches and reset loading")
        
        sut.$matches
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        sut.fetchNextPage(9)
        wait(for: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertEqual(sut.matches.count, 3)
        XCTAssertFalse(sut.isLoadingNextPage)
        XCTAssertEqual(sut.page, 2)
    }
}
