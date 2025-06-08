//
//  LeagueServiceTests.swift
//  SportycusTests
//
//  Created by Youssif Nasser on 06/06/2025.
//

import XCTest
@testable import Sportycus

final class LeagueServiceTests :XCTestCase {
    
    var service: LeagueService!
    
    override func setUp() {
        super.setUp()
        service = LeagueService()
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }
    
    func testFetchFootballLeagueSuccess (){
        let exp = expectation(description: "waiting fetch football league")
        service.getLeagues(completion: { res in
            if let res = res {
                XCTAssert(res.success == 1)
            }else{
                XCTAssertNil(res)
            }
            
            exp.fulfill()

        }, sport: SportType.football.path)
        waitForExpectations(timeout: 5)
    }
    
    func testFetchBasketballLeagueSuccess (){
        let exp = expectation(description: "waiting fetch basketball league")
        service.getLeagues(completion: { res in
            if let res = res {
                XCTAssert(res.success == 1)
            }else{
                XCTAssertNil(res)
            }

            exp.fulfill()

        }, sport: SportType.basketball.path)
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTennisLeagueSuccess (){
        let exp = expectation(description: "waiting fetch tennis league")
        service.getLeagues(completion: { res in
            if let res = res {
                XCTAssert(res.success == 1)
            }else{
                XCTAssertNil(res)
            }
            exp.fulfill()

        }, sport: SportType.tennis.path)
        waitForExpectations(timeout: 5)
    }
    
    func testFetchCricketLeagueSuccess (){
        let exp = expectation(description: "waiting fetch cricket league")
        service.getLeagues(completion: { res in
            if let res = res {
                XCTAssert(res.success == 1)
            }else{
                XCTAssertNil(res)
            }
            exp.fulfill()
        }, sport: SportType.cricket.path)
        waitForExpectations(timeout: 5)

    }
    
    func testFetchLeagueWithWrongQueryParam (){
        let exp = expectation(description: "waiting fetch league")
        service.getLeagues(completion: { res in
            if let res = res {
                XCTAssertNotNil(res)
            }else{
                XCTAssertNil(res)
            }
            exp.fulfill()
        }, sport: "")
        
        waitForExpectations(timeout: 5)
    }
    
    
}
