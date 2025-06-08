import XCTest
@testable import Sportycus

final class TeamServiceTests: XCTestCase {
    var service: TeamService!

    override func setUpWithError() throws {
        service = TeamService()
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testGetTeamSuccess() {
        let expectation = expectation(description: "fetch team details")
        
        service?.getTeam(completion: { response in
            if let res = response { // value
                XCTAssertNotNil(response)
                XCTAssertEqual(res.result.count, 1)
            } else { // error
                XCTFail("Response was nil")
                //XCTAssertNil(response)
            }
            expectation.fulfill()
        }, sport: "football", teamKey: 96, leagueId: 205)
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeamFail() {
        let expectation = expectation(description: "fetch team details")
        
        service?.getTeam(completion: { response in
            if let res = response { // value
                XCTAssertNotNil(response)
                XCTAssertEqual(res.result.count, 1)
            } else { // error
                //XCTFail("Response was nil")
                XCTAssertNil(response)
            }
            expectation.fulfill()
        }, sport: "footbll", teamKey: 96, leagueId: 205)
        waitForExpectations(timeout: 20)
    }

    

}


