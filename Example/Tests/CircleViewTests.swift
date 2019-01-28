//
//  CircleViewTests.swift
//  AHDownloadButton_Tests
//
//  Created by Amer Hukic on 28/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHDownloadButton

class CircleViewTests: XCTestCase {
    
    var circleView: CircleView!

    override func setUp() {
        super.setUp()
        circleView = CircleView()
    }

    override func tearDown() {
        super.tearDown()
        circleView = nil
    }
    
    func testSettingLineWidthShouldSetLayerLineWidth() {
        circleView.lineWidth = 2
        XCTAssert(circleView.circleLayer.lineWidth == 2)
    }
    
    func testSettingCircleColorShouldSetLayerStrokeColor() {
        circleView.circleColor = .white
        XCTAssert(circleView.circleLayer.strokeColor == UIColor.white.cgColor)
    }

    func testLayoutSubviewsShouldCreateCircleLayerPath() {
        circleView.layoutSubviews()
        XCTAssertNotNil(circleView.circleLayer.path)
    }


}
