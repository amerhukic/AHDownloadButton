//
//  HighlightableRoundedButtonTests.swift
//  AHDownloadButton_Tests
//
//  Created by Amer Hukic on 28/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHDownloadButton

class HighlightableRoundedButtonTests: XCTestCase {
    
    var highlightableRoundedButton: HighlightableRoundedButton!

    override func setUp() {
        highlightableRoundedButton = HighlightableRoundedButton()
    }

    override func tearDown() {
        highlightableRoundedButton = nil
    }

    func testSettingIsHighlightedShouldUpdateButtonColors() {
        highlightableRoundedButton.isHighlighted = true
        XCTAssertTrue(highlightableRoundedButton.backgroundColor == highlightableRoundedButton.highlightedBackgroundColor)
        XCTAssertTrue(highlightableRoundedButton.titleColor(for: .normal) == highlightableRoundedButton.highlightedTitleColor)
        
        highlightableRoundedButton.isHighlighted = false
        XCTAssertTrue(highlightableRoundedButton.backgroundColor == highlightableRoundedButton.nonhighlightedBackgroundColor)
        XCTAssertTrue(highlightableRoundedButton.titleColor(for: .normal) == highlightableRoundedButton.nonhighlightedTitleColor)
    }

    func testLayoutSubviewsShouldUpdateCornerRadius() {
        highlightableRoundedButton.layoutSubviews()
        XCTAssertTrue(highlightableRoundedButton.layer.cornerRadius == highlightableRoundedButton.frame.height / 2)
    }
    
}
