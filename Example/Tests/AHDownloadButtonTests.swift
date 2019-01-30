//
//  AHDownloadButtonTests.swift
//  AHDownloadButton_Tests
//
//  Created by Amer Hukic on 28/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AHDownloadButton

class AHDownloadButtonTests: XCTestCase {
    
    var downloadButton: AHDownloadButton!

    override func setUp() {
        super.setUp()
        downloadButton = AHDownloadButton()
    }

    override func tearDown() {
        super.tearDown()
        downloadButton = nil
    }
    
    func testInitWithAlignmentShouldSetAlignment() {
        let button = AHDownloadButton(alignment: .center)
        XCTAssert(button.contentHorizontalAlignment == .center)
    }
    
    func testInitWithFrameShouldSetAlignmentCenter() {
        let button = AHDownloadButton(frame: .zero)
        XCTAssert(button.contentHorizontalAlignment == .center)
    }
    
    func testSettingStartDownloadCustomizationPropertiesShouldSetCorrectPropertiesInStartDownloadButton() {
        downloadButton.startDownloadButtonHighlightedBackgroundColor = .red
        XCTAssert(downloadButton.startDownloadButtonHighlightedBackgroundColor == downloadButton.startDownloadButton.highlightedBackgroundColor)
        
        downloadButton.startDownloadButtonNonhighlightedBackgroundColor = .red
        XCTAssert(downloadButton.startDownloadButtonNonhighlightedBackgroundColor == downloadButton.startDownloadButton.nonhighlightedBackgroundColor)
        
        downloadButton.startDownloadButtonHighlightedTitleColor = .red
        XCTAssert(downloadButton.startDownloadButtonHighlightedTitleColor == downloadButton.startDownloadButton.highlightedTitleColor)
        
        downloadButton.startDownloadButtonNonhighlightedTitleColor = .red
        XCTAssert(downloadButton.startDownloadButtonNonhighlightedTitleColor == downloadButton.startDownloadButton.nonhighlightedTitleColor)
    }
    
    func testSettingPendingCustomizationPropertiesShouldSetCorrectPropertiesInPendingView() {
        downloadButton.pendingCircleColor = .red
        XCTAssert(downloadButton.pendingCircleColor == downloadButton.pendingCircleView.circleColor)

        downloadButton.pendingCircleLineWidth = 3
        XCTAssert(downloadButton.pendingCircleLineWidth == downloadButton.pendingCircleView.lineWidth)
    }
    
    func testSettingDownloadingButtonCustomizationPropertiesShouldSetCorrectPropertiesInDownloadingButton() {
        downloadButton.downloadingButtonNonhighlightedTrackCircleColor = .red
        XCTAssert(downloadButton.downloadingButtonNonhighlightedTrackCircleColor == downloadButton.downloadingButton.nonhighlightedTrackCircleColor)
        
        downloadButton.downloadingButtonHighlightedTrackCircleColor = .red
        XCTAssert(downloadButton.downloadingButtonHighlightedTrackCircleColor == downloadButton.downloadingButton.highlightedTrackCircleColor)
        
        downloadButton.downloadingButtonNonhighlightedProgressCircleColor = .red
        XCTAssert(downloadButton.downloadingButtonNonhighlightedProgressCircleColor == downloadButton.downloadingButton.nonhighlightedProgressCircleColor)
        
        downloadButton.downloadingButtonHighlightedProgressCircleColor = .red
        XCTAssert(downloadButton.downloadingButtonHighlightedProgressCircleColor == downloadButton.downloadingButton.highlightedProgressCircleColor)
        
        downloadButton.downloadingButtonNonhighlightedStopViewColor = .red
        XCTAssert(downloadButton.downloadingButtonNonhighlightedStopViewColor == downloadButton.downloadingButton.nonhighlightedStopViewColor)
        
        downloadButton.downloadingButtonHighlightedStopViewColor = .red
        XCTAssert(downloadButton.downloadingButtonHighlightedStopViewColor == downloadButton.downloadingButton.highlightedStopViewColor)
        
        downloadButton.downloadingButtonCircleLineWidth = 4
        XCTAssert(downloadButton.downloadingButtonCircleLineWidth == downloadButton.downloadingButton.circleViewLineWidth)
    }
    
    func testSettingDownloadedButtonCustomizationPropertiesShouldSetCorrectPropertiesInDownloadedButton() {
        downloadButton.downloadedButtonHighlightedBackgroundColor = .red
        XCTAssert(downloadButton.downloadedButtonHighlightedBackgroundColor == downloadButton.downloadedButton.highlightedBackgroundColor)

        downloadButton.downloadedButtonNonhighlightedBackgroundColor = .red
        XCTAssert(downloadButton.downloadedButtonNonhighlightedBackgroundColor == downloadButton.downloadedButton.nonhighlightedBackgroundColor)

        downloadButton.downloadedButtonHighlightedTitleColor = .red
        XCTAssert(downloadButton.downloadedButtonHighlightedTitleColor == downloadButton.downloadedButton.highlightedTitleColor)

        downloadButton.downloadedButtonNonhighlightedTitleColor = .red
        XCTAssert(downloadButton.downloadedButtonNonhighlightedTitleColor == downloadButton.downloadedButton.nonhighlightedTitleColor)
    }

    func testSettingStateShouldNotifyDelegate() {
        let delegate = AHDownloadButtonDelegateMock()
        downloadButton.delegate = delegate
        
        downloadButton.state = .startDownload
        
        XCTAssertTrue(delegate.didCallStateChangeMethod)
    }
    
    func testSettingStateShouldExecuteCallbackClosure() {
        var didCall = false
        downloadButton.downloadButtonStateChangedAction = { _, _ in
            didCall = true
        }
        
        downloadButton.state = .startDownload
        
        XCTAssertTrue(didCall)
    }
    
    func testTappingButtonShouldNotifyDelegate() {
        let delegate = AHDownloadButtonDelegateMock()
        downloadButton.delegate = delegate
        
        downloadButton.startDownloadButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(delegate.didCallTappedMethod)
        
        delegate.didCallTappedMethod = false
        downloadButton.downloadingButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(delegate.didCallTappedMethod)
        
        delegate.didCallTappedMethod = false
        downloadButton.downloadedButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(delegate.didCallTappedMethod)
    }
    
    func testTappingButtonShouldExecuteCallbackClosure() {
        var didCall = false
        downloadButton.didTapDownloadButtonAction = { _, _ in
            didCall = true
        }
        
        downloadButton.startDownloadButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didCall)
        
        didCall = false
        downloadButton.downloadingButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didCall)
        
        didCall = false
        downloadButton.downloadedButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didCall)
    }
}
