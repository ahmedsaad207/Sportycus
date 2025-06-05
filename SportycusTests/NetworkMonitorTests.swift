import XCTest
@testable import Sportycus

final class NetworkMonitorTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIsConnected() throws {
        NetworkMonitor.shared.fetchData { response, error in
            if let response = response {
                XCTAssertEqual(response.count, 3)
                XCTAssertNotNil(response)
                XCTAssertNil(error)
            } else {
                XCTAssertNil(response)
                XCTAssertEqual(error as? NetworkError, NetworkError.noInternet)
            }
        }
    }
}


