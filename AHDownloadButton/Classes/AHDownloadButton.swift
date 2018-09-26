//
//  AHDownloadButton.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

public protocol AHDownloadButtonDelegate: class {
    func didTapDownloadButton(withState state: AHDownloadButton.State)
}

public class AHDownloadButton: UIView {
    
    public enum State {
        case startDownload
        case pending
        case downloading
        case downloaded
    }
    
    // MARK: Public properties
    
    /// Start download button customisation properties
    
    public var startDownloadButtonTitle: String = "GET" {
        didSet {
            startDownloadButton.setTitle(startDownloadButtonTitle, for: .normal)
        }
    }
    
    public var startDownloadButtonTitleFont: UIFont = .boldSystemFont(ofSize: 15) {
        didSet {
            startDownloadButton.titleLabel?.font = startDownloadButtonTitleFont
        }
    }
    
    public var startDownloadButtonTitleSidePadding: CGFloat = 12
    
    public var startDownloadButtonHighlightedBackgroundColor: UIColor = Color.Gray.light {
        didSet {
            startDownloadButton.highlightedBackgroundColor = startDownloadButtonHighlightedBackgroundColor
        }
    }
    
    public var startDownloadButtonNonhighlightedBackgroundColor: UIColor = Color.Gray.medium {
        didSet {
            startDownloadButton.nonhighlightedBackgroundColor = startDownloadButtonNonhighlightedBackgroundColor
        }
    }
    
    public var startDownloadButtonHighlightedTitleColor: UIColor = Color.Blue.light {
        didSet {
            startDownloadButton.highlightedTitleColor = startDownloadButtonHighlightedTitleColor
        }
    }
    
    public var startDownloadButtonNonhighlightedTitleColor: UIColor = Color.Blue.medium {
        didSet {
            startDownloadButton.nonhighlightedTitleColor = startDownloadButtonNonhighlightedTitleColor
        }
    }
    
    /// Pending view customisation properties
    
    public var pendingCircleColor: UIColor = Color.Gray.dark {
        didSet {
            pendingCircleView.circleColor = pendingCircleColor
        }
    }
    
    public var pendingCircleLineWidth: CGFloat = 2 {
        didSet {
            pendingCircleView.lineWidth = pendingCircleLineWidth
        }
    }
    
    /// Downloading button customisation properties
    
    public var downloadingButtonNonhighlightedTrackCircleColor: UIColor = Color.Gray.medium {
        didSet {
            downloadingButton.nonhighlightedTrackCircleColor = downloadingButtonNonhighlightedTrackCircleColor
        }
    }
    
    public var downloadingButtonHighlightedTrackCircleColor: UIColor = Color.Gray.light {
        didSet {
            downloadingButton.highlightedTrackCircleColor = downloadingButtonHighlightedTrackCircleColor
        }
    }
    
    public var downloadingButtonNonhighlightedProgressCircleColor: UIColor = Color.Blue.medium {
        didSet {
            downloadingButton.nonhighlightedProgressCircleColor = downloadingButtonNonhighlightedProgressCircleColor
        }
    }
    
    public var downloadingButtonHighlightedProgressCircleColor: UIColor = Color.Blue.light {
        didSet {
            downloadingButton.highlightedProgressCircleColor = downloadingButtonHighlightedProgressCircleColor
        }
    }
    
    public var downloadingButtonNonhighlightedStopViewColor: UIColor = Color.Blue.medium {
        didSet {
            downloadingButton.nonhighlightedStopViewColor = downloadingButtonNonhighlightedStopViewColor
        }
    }
    
    public var downloadingButtonHighlightedStopViewColor: UIColor = Color.Blue.light {
        didSet {
            downloadingButton.highlightedStopViewColor = downloadingButtonHighlightedStopViewColor
        }
    }
    
    public var progress: CGFloat = 0 {
        didSet {
            downloadingButton.progress = progress
        }
    }
    
    /// Downloaded button customisation properties
    
    public var downloadedButtonTitle: String = "OPEN" {
        didSet {
            downloadedButton.setTitle(downloadedButtonTitle, for: .normal)
        }
    }
    
    public var downloadedButtonTitleFont: UIFont = .boldSystemFont(ofSize: 15) {
        didSet {
            downloadedButton.titleLabel?.font = downloadedButtonTitleFont
        }
    }
    
    public var downloadedButtonTitleSidePadding: CGFloat = 12
    
    public var downloadedButtonHighlightedBackgroundColor: UIColor = Color.Gray.light {
        didSet {
            downloadedButton.highlightedBackgroundColor = downloadedButtonHighlightedBackgroundColor
        }
    }
    
    public var downloadedButtonNonhighlightedBackgroundColor: UIColor = Color.Gray.medium {
        didSet {
            downloadedButton.nonhighlightedBackgroundColor = downloadedButtonNonhighlightedBackgroundColor
        }
    }
    
    public var downloadedButtonHighlightedTitleColor: UIColor = Color.Blue.light {
        didSet {
            downloadedButton.highlightedTitleColor = downloadedButtonHighlightedTitleColor
        }
    }
    
    public var downloadedButtonNonhighlightedTitleColor: UIColor = Color.Blue.medium {
        didSet {
            downloadedButton.nonhighlightedTitleColor = downloadedButtonNonhighlightedTitleColor
        }
    }
    
    /// State transformation
    
    public var state: State = .startDownload {
        didSet {
            animationQueue.async { [currentState = state] in
                self.animationDispatchGroup.enter()
                
                var delay: TimeInterval = 0
                if oldValue == .downloading && currentState == .downloaded && self.downloadingButton.progress == 1 {
                    delay = self.downloadingButton.progressCircleView.progressAnimationDuration
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.animateTransition(from: oldValue, to: currentState)
                }
                self.animationDispatchGroup.wait()
            }
        }
    }
    
    public var transitionAnimationDuration: TimeInterval = 0.1
    
    /// Callbacks
    
    public weak var delegate: AHDownloadButtonDelegate?
    
    public var didTapDownloadButtonAction: ((_ currentState: State) -> Void)?

    // MARK: Private properties
    
    let startDownloadButton: HighlightableRoundedButton = {
        let button = HighlightableRoundedButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let pendingCircleView: CircleView = {
        let view = CircleView()
        view.endAngleRadians = view.startAngleRadians + 12 * .pi / 7
        return view
    }()
    
    let downloadingButton: ProgressButton = {
        let button = ProgressButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let downloadedButton: HighlightableRoundedButton = {
        let button = HighlightableRoundedButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Animation
    
    let animationDispatchGroup = DispatchGroup()
    let animationQueue = DispatchQueue(label: "com.amerhukic.animation")
    
    // MARK: Constraints
    
    var startDownloadButtonWidthConstraint: NSLayoutConstraint!
    var pendingViewWidthConstraint: NSLayoutConstraint!
    var downloadingButtonWidthConstraint: NSLayoutConstraint!
    var downloadedButtonWidthConstraint: NSLayoutConstraint!
    
    var startDownloadButtonTitleWidth: CGFloat = 0 {
        didSet {
            startDownloadButtonWidthConstraint.constant = startDownloadButtonFullWidth
        }
    }
    
    var downloadedButtonTitleWidth: CGFloat = 0 {
        didSet {
            downloadedButtonWidthConstraint.constant = downloadedButtonFullWidth
        }
    }
    
    var startDownloadButtonFullWidth: CGFloat {
        return startDownloadButtonTitleWidth + 2 * startDownloadButtonTitleSidePadding
    }
    
    var downloadedButtonFullWidth: CGFloat {
        return downloadedButtonTitleWidth + 2 * downloadedButtonTitleSidePadding
    }
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(startDownloadButton)
        setUpStartDownloadButtonProperties()
        setUpStartDownloadButtonConstraints()
        
        addSubview(pendingCircleView)
        setUpPendingCircleViewProperties()
        setUpPendingButtonConstraints()
        
        addSubview(downloadingButton)
        setUpDownloadingButtonProperties()
        setUpDownloadingButtonConstraints()
        
        addSubview(downloadedButton)
        setUpDownloadedButtonProperties()
        setUpDownloadedButtonConstraints()
    }
    
    // MARK: Style customisation
    
    private func setUpStartDownloadButtonProperties() {
        startDownloadButton.setTitle(startDownloadButtonTitle, for: .normal)
        startDownloadButton.titleLabel?.font = startDownloadButtonTitleFont
        startDownloadButton.highlightedBackgroundColor = startDownloadButtonHighlightedBackgroundColor
        startDownloadButton.nonhighlightedBackgroundColor = startDownloadButtonNonhighlightedBackgroundColor
        startDownloadButton.highlightedTitleColor = startDownloadButtonHighlightedTitleColor
        startDownloadButton.nonhighlightedTitleColor = startDownloadButtonNonhighlightedTitleColor
    }
    
    private func setUpPendingCircleViewProperties() {
        pendingCircleView.circleColor = pendingCircleColor
        pendingCircleView.lineWidth = pendingCircleLineWidth
        pendingCircleView.alpha = 0
    }
    
    private func setUpDownloadingButtonProperties() {
        downloadingButton.highlightedTrackCircleColor = downloadingButtonHighlightedTrackCircleColor
        downloadingButton.nonhighlightedTrackCircleColor = downloadingButtonNonhighlightedTrackCircleColor
        downloadingButton.highlightedProgressCircleColor = downloadingButtonHighlightedProgressCircleColor
        downloadingButton.nonhighlightedProgressCircleColor = downloadingButtonNonhighlightedProgressCircleColor
        downloadingButton.highlightedStopViewColor = downloadingButtonHighlightedStopViewColor
        downloadingButton.nonhighlightedStopViewColor = downloadingButtonNonhighlightedStopViewColor
        downloadingButton.alpha = 0
    }
    
    private func setUpDownloadedButtonProperties() {
        downloadedButton.setTitle(downloadedButtonTitle, for: .normal)
        downloadedButton.titleLabel?.font = downloadedButtonTitleFont
        downloadedButton.highlightedBackgroundColor = downloadedButtonHighlightedBackgroundColor
        downloadedButton.nonhighlightedBackgroundColor = downloadedButtonNonhighlightedBackgroundColor
        downloadedButton.highlightedTitleColor = downloadedButtonHighlightedTitleColor
        downloadedButton.nonhighlightedTitleColor = downloadedButtonNonhighlightedTitleColor
        downloadedButton.alpha = 0
    }
    
    // MARK: Constraints setup
    
    private func setUpStartDownloadButtonConstraints() {
        startDownloadButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: startDownloadButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: startDownloadButton,
                                                  attribute: .bottom, relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let centerXConstraint = NSLayoutConstraint(item: startDownloadButton,
                                                   attribute: .centerX, relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        
        startDownloadButtonWidthConstraint = NSLayoutConstraint(item: startDownloadButton,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .width,
                                                                multiplier: 1,
                                                                constant: 50)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, centerXConstraint, startDownloadButtonWidthConstraint])
    }
    
    private func setUpPendingButtonConstraints() {
        pendingCircleView.centerToSuperview()
        let heightConstraint = NSLayoutConstraint(item: pendingCircleView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: pendingCircleView,
                                                  attribute: .width,
                                                  multiplier: 1,
                                                  constant: 0)
        
        pendingViewWidthConstraint = NSLayoutConstraint(item: pendingCircleView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 30)
        NSLayoutConstraint.activate([heightConstraint, pendingViewWidthConstraint])
    }
    
    private func setUpDownloadingButtonConstraints() {
        downloadingButton.centerToSuperview()
        let heightConstraint = NSLayoutConstraint(item: downloadingButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: downloadingButton,
                                                  attribute: .width,
                                                  multiplier: 1,
                                                  constant: 0)
        
        downloadingButtonWidthConstraint = NSLayoutConstraint(item: downloadingButton,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .width,
                                                        multiplier: 1,
                                                        constant: 30)
        NSLayoutConstraint.activate([heightConstraint, downloadingButtonWidthConstraint])
    }
    
    private func setUpDownloadedButtonConstraints() {
        downloadedButton.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: downloadedButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: downloadedButton,
                                                  attribute: .bottom, relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let centerXConstraint = NSLayoutConstraint(item: downloadedButton,
                                                   attribute: .centerX, relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        
        downloadedButtonWidthConstraint = NSLayoutConstraint(item: downloadedButton,
                                                                attribute: .width,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .width,
                                                                multiplier: 1,
                                                                constant: 50)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, centerXConstraint, downloadedButtonWidthConstraint])
    }
    
    // MARK: Method overrides
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = min(frame.width, frame.height)
        pendingViewWidthConstraint.constant = width
        downloadingButtonWidthConstraint.constant = width
        
        if startDownloadButtonTitleWidth == 0 {
            startDownloadButtonTitleWidth = startDownloadButton.titleWidth
        }
        
        if downloadedButtonTitleWidth == 0 {
            downloadedButtonTitleWidth = downloadedButton.titleWidth
        }
    }
    
    // MARK: Action methods
    
    @objc private func currentButtonTapped() {
        delegate?.didTapDownloadButton(withState: state)
        didTapDownloadButtonAction?(state)
    }
    
}
