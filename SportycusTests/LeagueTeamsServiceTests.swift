//
//  LeagueTeamsServiceTests.swift
//  Sportycus
//
//  Created by Youssif Nasser on 06/06/2025.
//

//import Testing
import XCTest
@testable import Sportycus

final class LeagueTeamsServiceTests : XCTestCase{
    
    
    
    func testFetchTeamsByLeagueId(){
        let exp = expectation(description: "")
        
        LeagueTeamsService.getTeamsByLeagueId(completion: { res in
            if let res = res {
                XCTAssertNotNil(res)
            }else{
                XCTFail("Response was nil")
            }
            
            exp.fulfill()
            
            
        }, leagueId: 5, sportName: SportType.football.path)
        
        waitForExpectations(timeout: 5)
    }
}
