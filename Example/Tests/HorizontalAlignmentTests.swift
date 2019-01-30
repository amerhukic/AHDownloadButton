//
//  HorizontalAlignmentTests.swift
//  AHDownloadButton_Tests
//
//  Created by Amer Hukic on 30/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHDownloadButton

class HorizontalAlignmentTests: XCTestCase {
    
    var horizontalAlignment: AHDownloadButton.HorizontalAlignment!

    override func setUp() {
        horizontalAlignment = .left
    }

    override func tearDown() {
        horizontalAlignment = nil
    }

    func testHorizontalAlignmentLeftShouldReturnLeftLayoutAttribute() {
        horizontalAlignment = .left
        XCTAssert(horizontalAlignment.relativeLayoutAttribute == .left)
    }
    
    func testHorizontalAlignmentCenterShouldReturnCenterXLayoutAttribute() {
        horizontalAlignment = .center
        XCTAssert(horizontalAlignment.relativeLayoutAttribute == .centerX)
    }
    
    func testHorizontalAlignmentRightShouldReturnRightLayoutAttribute() {
        horizontalAlignment = .right
        XCTAssert(horizontalAlignment.relativeLayoutAttribute == .right)
    }

}
