import XCTest
@testable import Sportycus

final class LeaguePlayersServiceTests: XCTestCase {
   
    func testFetchTennisPlayers(){
        let exp = expectation(description: "")
        LeaguePlayersService.getPlayersByLeagueId(completion: { res in
            if let res = res {
                XCTAssertNotNil(res)
            }else{
                XCTFail("Response was nil")
            }

            exp.fulfill()
        }, leagueId: 2646, sportName: "")

        waitForExpectations(timeout: 10	)
    }
}

