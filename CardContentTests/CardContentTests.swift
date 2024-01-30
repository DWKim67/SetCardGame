//
//  CardContentTests.swift
//  CardContentTests
//
//  Created by Daniel Kim on 2024-01-29.
//

import XCTest

final class CardContentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFullEquality() throws {
        let cardContent1 = CardContent(color: "blue", number: 1, shape: "Circle", shading: "Opaque")
        let cardContent2 = CardContent(color: "blue", number: 1, shape: "Circle", shading: "Opaque")
        
        XCTAssertTrue(cardContent1 == cardContent2)
    }

    

}
