//
//  AHDownloadButton.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

public final class AHDownloadButton: UIView {
    
    public enum State {
        case startDownload
        case pending
        case downloading
        case downloaded
    }

    public enum HorizontalAlignment: Int {
        case center, left, right

        var relativeLayoutAttribute: NSLayoutConstraint.Attribute {
            switch self {
            case .center: return .centerX
            case .right: return .right
            case .left: return .left
            }
        }
    }
    
    // MARK: Public properties
    
    /// Start download button customisation properties
    
    public var startDownloadButtonTitle: String = "GET" {
        didSet {
            startDownloadButton.setTitle(startDownloadButtonTitle, for: .normal)
            startDownloadButtonTitleWidth = 0
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

    public var downloadingButtonCircleLineWidth: CGFloat = 6 {
        didSet {
            downloadingButton.circleViewLineWidth = downloadingButtonCircleLineWidth
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
            downloadedButtonTitleWidth = 0
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
            downloadButtonStateChangedAction?(self, state)
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

    public var didTapDownloadButtonAction: ((AHDownloadButton, State) -> Void)?
    
    public var downloadButtonStateChangedAction: ((AHDownloadButton, State) -> Void)?

    // MARK: Private properties
    
    lazy var startDownloadButton: HighlightableRoundedButton = {
        let button = HighlightableRoundedButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var pendingCircleView: CircleView = {
        let view = CircleView()
        view.endAngleRadians = view.startAngleRadians + 12 * .pi / 7
        return view
    }()
    
    lazy var downloadingButton: ProgressButton = {
        let button = ProgressButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var downloadedButton: HighlightableRoundedButton = {
        let button = HighlightableRoundedButton()
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        return button
    }()

    let contentHorizontalAlignment: HorizontalAlignment

    // MARK: Animation
    
    let animationDispatchGroup = DispatchGroup()
    let animationQueue = DispatchQueue(label: "com.amerhukic.animation")
    
    // MARK: Constraints
    
    var startDownloadButtonWidthConstraint: NSLayoutConstraint!
    var pendingViewWidthConstraint: NSLayoutConstraint!
    var downloadingButtonWidthConstraint: NSLayoutConstraint!
    var downloadedButtonWidthConstraint: NSLayoutConstraint!
    var horizontalAlignmentAttribute: NSLayoutConstraint.Attribute {
        return contentHorizontalAlignment.relativeLayoutAttribute
    }
    
    var startDownloadButtonTitleWidth: CGFloat = 0
    var downloadedButtonTitleWidth: CGFloat = 0
    
    var startDownloadButtonFullWidth: CGFloat {
        return startDownloadButtonTitleWidth + 2 * startDownloadButtonTitleSidePadding
    }
    
    var downloadedButtonFullWidth: CGFloat {
        return downloadedButtonTitleWidth + 2 * downloadedButtonTitleSidePadding
    }

    var pendingButtonFullWidth: CGFloat {
        return AHDownloadButton.circleWidth + 2 * startDownloadButtonTitleSidePadding
    }

    var downloadingButtonFullWidth: CGFloat {
        return AHDownloadButton.circleWidth + 2 * downloadedButtonTitleSidePadding
    }

    
    // MARK: Initializers
    
    public init(alignment: HorizontalAlignment) {
        contentHorizontalAlignment = alignment
        super.init(frame: .zero)
        commonInit()
    }

    public override init(frame: CGRect) {
        contentHorizontalAlignment = .center
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        contentHorizontalAlignment = .center
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

    private static let circleWidth: CGFloat = 30.0
    
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

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currentButtonTapped))
        pendingCircleView.addGestureRecognizer(tapGesture)
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
        let topConstraint = startDownloadButton.constraint(attribute: .top, toItem: self, toAttribute: .top)
        
        let bottomConstraint = startDownloadButton.constraint(attribute: .bottom, toItem: self, toAttribute: .bottom)

        let horizontalPositionConstraint = startDownloadButton.constraint(attribute: horizontalAlignmentAttribute, toItem: self, toAttribute: horizontalAlignmentAttribute)
        
        startDownloadButtonWidthConstraint = startDownloadButton.constraint(attribute: .width, relation: .equal, toItem: nil, toAttribute: .notAnAttribute, constant: 0)

        NSLayoutConstraint.activate([topConstraint, bottomConstraint, horizontalPositionConstraint, startDownloadButtonWidthConstraint])
    }
    
    private func setUpPendingButtonConstraints() {
        let horizontalPositionConstraint = pendingCircleView.constraint(attribute: horizontalAlignmentAttribute, toItem: self, toAttribute: horizontalAlignmentAttribute)
        let heightConstraint = pendingCircleView.constraint(attribute: .height, relation: .equal, toItem: pendingCircleView, toAttribute: .width)
        let verticalPositionConstraint = pendingCircleView.constraint(attribute: .centerY, toItem: self, toAttribute: .centerY)
        
        pendingViewWidthConstraint = pendingCircleView.constraint(attribute: .width, constant: AHDownloadButton.circleWidth)
        NSLayoutConstraint.activate([horizontalPositionConstraint, verticalPositionConstraint, heightConstraint, pendingViewWidthConstraint])
    }
    
    private func setUpDownloadingButtonConstraints() {
        let horizontalPositionConstraint = downloadingButton.constraint(attribute: horizontalAlignmentAttribute, toItem: self, toAttribute: horizontalAlignmentAttribute)
        let verticalPositionConstraint = downloadingButton.constraint(attribute: .centerY, toItem: self, toAttribute: .centerY)

        let heightConstraint = downloadingButton.constraint(attribute: .height, toItem: downloadingButton, toAttribute: .width)

        downloadingButtonWidthConstraint = downloadingButton.constraint(attribute: .width, constant: AHDownloadButton.circleWidth)

        NSLayoutConstraint.activate([horizontalPositionConstraint, verticalPositionConstraint, heightConstraint, downloadingButtonWidthConstraint])
    }
    
    private func setUpDownloadedButtonConstraints() {
        let topConstraint = downloadedButton.constraint(attribute: .top, toItem: self, toAttribute: .top)
        let bottomConstraint = downloadedButton.constraint(attribute: .bottom, toItem: self, toAttribute: .bottom)
        let horizontalPositionConstraint = downloadedButton.constraint(attribute: horizontalAlignmentAttribute, toItem: self, toAttribute: horizontalAlignmentAttribute)

        // This constraint will be changed later on (in layoutSubviews), here we're just creating it
        downloadedButtonWidthConstraint = downloadedButton.constraint(attribute: .width, relation: .equal, toItem: nil, toAttribute: .notAnAttribute, constant: 0)

        NSLayoutConstraint.activate([topConstraint, bottomConstraint, horizontalPositionConstraint, downloadedButtonWidthConstraint])
    }
    
    // MARK: Method overrides
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = min(frame.width, frame.height)
        pendingViewWidthConstraint.constant = width
        downloadingButtonWidthConstraint.constant = width
        
        if startDownloadButtonTitleWidth == 0 || downloadedButtonTitleWidth == 0 {
            startDownloadButtonTitleWidth = startDownloadButton.titleWidth
        }
        
        if downloadedButtonTitleWidth == 0 {
            downloadedButtonTitleWidth = downloadedButton.titleWidth
            let maxWidth = max(startDownloadButtonFullWidth, downloadedButtonFullWidth)
            startDownloadButtonWidthConstraint.constant = maxWidth
            downloadedButtonWidthConstraint.constant = maxWidth
        }
        invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {
        switch state {
        case .pending:
            return CGSize(width: pendingButtonFullWidth, height: super.intrinsicContentSize.height)
        case .downloading:
            return CGSize(width: downloadingButtonFullWidth, height: super.intrinsicContentSize.height)
        case .startDownload, .downloaded:
            let maxWidth = max(startDownloadButtonFullWidth, downloadedButtonFullWidth)
            return CGSize(width: maxWidth, height: super.intrinsicContentSize.height)
        }
    }
    
    // MARK: Action methods
    
    @objc private func currentButtonTapped() {
        didTapDownloadButtonAction!(self, state)
    }
    
}
