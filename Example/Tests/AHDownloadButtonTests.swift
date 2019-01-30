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
