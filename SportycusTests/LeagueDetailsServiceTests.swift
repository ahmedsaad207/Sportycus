//
//  LeagueDetailsServiceTests.swift
//  SportycusTests
//
//  Created by Youssif Nasser on 06/06/2025.
//

import XCTest
@testable import Sportycus

final class LeagueDetailsServiceTests: XCTestCase {


    
    func testFetchLeagueDetailsSuccessful(){
        let exp = expectation(description: "")
        LeagueDetailsService.getLeagueDetails(for: SportType(rawValue: "Football")!, leagueID: 207) { res in
            if let res = res {
                XCTAssertNotNil(res)
            }else{
                XCTFail("Response was nil")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testFetchLeagueDetailsFailure(){
        let exp = expectation(description: "")
        LeagueDetailsService.getLeagueDetails(for: SportType(rawValue: "Football")!, leagueID: -200) { res in
            if let res = res {
                XCTAssertNotNil(res)
            }else{
                XCTFail("Response was nil")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
