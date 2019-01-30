//
//  AHDownloadButtonDelegateMock.swift
//  AHDownloadButton_Example
//
//  Created by Amer Hukic on 29/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import AHDownloadButton

class AHDownloadButtonDelegateMock: AHDownloadButtonDelegate {
    
    var didCallStateChangeMethod = false
    var didCallTappedMethod = false

    func downloadButton(_ downloadButton: AHDownloadButton, stateChanged state: AHDownloadButton.State) {
        didCallStateChangeMethod = true
    }
    
    func downloadButton(_ downloadButton: AHDownloadButton, tappedWithState state: AHDownloadButton.State) {
        didCallTappedMethod = true
    }
    
}
