import Combine
@testable import PandaScoreCS
import XCTest

final class DetailMatchViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    let match: Match = .fixture(
        opponents: [
            .fixture(),
            .fixture()
        ]
    )
    
    func test_fetch_whenServiceIsFailing_shouldSetStateToLoaded() {
        //Given
        let detailMatchServiceStub = DetailMatchServiceStub()
        let expectedError = APIError.invalidResponse
        detailMatchServiceStub.getPlayerResultToBeReturned = .failure(expectedError)
        
        let sut = DetailMatchViewModel(service: detailMatchServiceStub, matchDate: "")
        let expectedState: DetailState = .error
        
        let loadExpectation = expectation(description: "State should be set to error")
        sut.$detailState
            .sink { state in
                if state == expectedState {
                    loadExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        //When
        sut.fetchMatch(match)
        wait(for: [loadExpectation], timeout: 1.0)
        
        //Then
        XCTAssertEqual(sut.detailState, expectedState)
    }
    
    func test_fetch_whenServiceIsSuccessful_shouldSetStateToLoaded() {
        // Given
        let detailMatchServiceStub = DetailMatchServiceStub()
        let stubbedPlayers: [Player] = [
            .init(
                id: 1,
                nickname: "Nickname 1",
                firstName: "First name",
                lastName: "",
                imageUrl: ""
            ),
            .init(
                id: 2,
                nickname: "Nickname 2",
                firstName: "First name",
                lastName: "",
                imageUrl: ""
            ),
            .init(
                id: 3,
                nickname: "Nickname 3",
                firstName: "First name",
                lastName: "",
                imageUrl: ""
            ),
        ]
        detailMatchServiceStub.getPlayerResultToBeReturned = .success(stubbedPlayers)
        let sut = DetailMatchViewModel(service: detailMatchServiceStub, matchDate: "")
        let expectedState: DetailState = .loaded(stubbedPlayers, stubbedPlayers)
        
        let loadExpectation = expectation(description: "State should be set to loaded")
        sut.$detailState
            .dropFirst()
            .sink { _ in
                loadExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        //When
        sut.fetchMatch(match)
        wait(for: [loadExpectation], timeout: 1.0)
        
        //Then
        XCTAssertEqual(sut.detailState, expectedState)
    }
}
