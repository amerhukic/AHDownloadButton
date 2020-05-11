//
//  AHDownloadButton+StateTransitionAnimation.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 04/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

extension AHDownloadButton {
    
    func animateTransition(from oldState: State, to newState: State) {
        
        let completion: (Bool) -> Void = { completed in
            guard completed else { return }
            self.resetStateViews(except: newState)
            self.animationDispatchGroup.leave()
        }
                
        switch (oldState, newState) {
        case (.startDownload, .pending):
            animateTransitionFromStartDownloadToPending(completion: completion)
            
        case (.startDownload, .downloading):
            animateTransitionFromStartDownloadToDownloading(completion: completion)
            
        case (.pending, .startDownload):
            animateTransitionFromPendingToStartDownload(completion: completion)
            
        case (.pending, .downloading):
            animateTransitionFromPendingToDownloading(completion: completion)
            
        case (.downloading, .downloaded):
            animateTransitionFromDownloadingToDownloaded(completion: completion)

        case (.downloading, .startDownload):
            animateTransitionFromDownloadingToStartDownload(completion: completion)

        default:
            handleUnsupportedTransitionAnimation(toState: newState)
        }
    }
        
    private func animateTransitionFromStartDownloadToPending(completion: @escaping (Bool) -> Void) {
        startDownloadButton.titleLabel?.alpha = 0
        startDownloadButtonWidthConstraint.constant = pendingViewWidthConstraint.constant
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.layoutIfNeeded()
        }, completion: { completed in
            completion(completed)
            guard completed else { return }
            self.pendingCircleView.alpha = 1
            self.pendingCircleView.startSpinning()
        })
    }
    
    private func animateTransitionFromStartDownloadToDownloading(completion: @escaping (Bool) -> Void) {
        startDownloadButton.titleLabel?.alpha = 0
        startDownloadButtonWidthConstraint.constant = downloadingButtonWidthConstraint.constant
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.layoutIfNeeded()
        }, completion: { completed in
            completion(completed)
            guard completed else { return }
            self.downloadingButton.alpha = 1
        })
    }
    
    private func animateTransitionFromPendingToStartDownload(completion: @escaping (Bool) -> Void) {
        startDownloadButtonWidthConstraint.constant = pendingViewWidthConstraint.constant
        layoutIfNeeded()
        
        startDownloadButton.alpha = 1
        startDownloadButtonWidthConstraint.constant = startDownloadButtonFullWidth
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.pendingCircleView.alpha = 0
            self.startDownloadButton.titleLabel?.alpha = 1
            self.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func animateTransitionFromPendingToDownloading(completion: @escaping (Bool) -> Void) {
        pendingCircleView.alpha = 1
        downloadingButton.alpha = 0
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.pendingCircleView.alpha = 0
            self.downloadingButton.alpha = 1
        }, completion: completion)
    }
    
    private func animateTransitionFromDownloadingToDownloaded(completion: @escaping (Bool) -> Void) {
        downloadedButton.alpha = 1
        downloadedButtonWidthConstraint.constant = downloadingButtonWidthConstraint.constant
        layoutIfNeeded()
        
        downloadedButton.titleLabel?.alpha = 0
        downloadedButtonWidthConstraint.constant = downloadedButtonFullWidth
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.downloadingButton.alpha = 0
            self.downloadedButton.titleLabel?.alpha = 1
            self.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func animateTransitionFromDownloadingToStartDownload(completion: @escaping (Bool) -> Void) {
        startDownloadButtonWidthConstraint.constant = downloadingButtonWidthConstraint.constant
        layoutIfNeeded()
        
        downloadingButton.alpha = 0
        startDownloadButton.alpha = 1
        startDownloadButtonWidthConstraint.constant = startDownloadButtonFullWidth
        UIView.animate(withDuration: transitionAnimationDuration, animations: {
            self.startDownloadButton.titleLabel?.alpha = 1
            self.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func handleUnsupportedTransitionAnimation(toState newState: State) {
        switch newState {
        case .startDownload:
            startDownloadButton.alpha = 1
        case .pending:
            pendingCircleView.alpha = 1
        case .downloading:
            downloadingButton.alpha = 1
        case .downloaded:
            downloadedButton.alpha = 1
        }
        resetStateViews(except: newState)
        animationDispatchGroup.leave()
    }

    private func resetStateViews(except state: State) {

        if state != .startDownload {
            startDownloadButton.alpha = 0
            startDownloadButton.titleLabel?.alpha = 1
            startDownloadButtonWidthConstraint.constant = startDownloadButtonFullWidth
        }
        
        if state != .pending {
            pendingCircleView.alpha = 0
        }
        
        if state != .downloading {
            downloadingButton.alpha = 0
            progress = 0
        }
        
        if state != .downloaded {
            downloadedButton.alpha = 0
            downloadedButton.titleLabel?.alpha = 1
            downloadedButtonWidthConstraint.constant = downloadedButtonFullWidth
        }
        
    }
    
}
