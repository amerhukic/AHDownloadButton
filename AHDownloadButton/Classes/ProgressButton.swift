//
//  ProgressButton.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

final class ProgressButton: UIControl {
    
    // MARK: Properties

    var circleViewLineWidth: CGFloat = 6 {
        didSet {
            progressCircleView.lineWidth = circleViewLineWidth
            trackCircleView.lineWidth = circleViewLineWidth
        }
    }
    
    let stopView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var trackCircleView: CircleView = {
        let circleView = CircleView()
        circleView.lineWidth = circleViewLineWidth
        circleView.isUserInteractionEnabled = false
        return circleView
    }()
    
    lazy var progressCircleView: ProgressCircleView = {
        let view = ProgressCircleView()
        view.lineWidth = circleViewLineWidth
        view.isUserInteractionEnabled = false
        return view
    }()
    
    var nonhighlightedTrackCircleColor: UIColor = Color.Gray.medium {
        didSet {
            updateColors()
        }
    }
    
    var highlightedTrackCircleColor: UIColor = Color.Gray.light {
        didSet {
            updateColors()
        }
    }
    
    var nonhighlightedProgressCircleColor: UIColor = Color.Blue.medium {
        didSet {
            updateColors()
        }
    }
    
    var highlightedProgressCircleColor: UIColor = Color.Blue.light {
        didSet {
            updateColors()
        }
    }
    
    var nonhighlightedStopViewColor: UIColor = Color.Blue.medium {
        didSet {
            updateColors()
        }
    }
    
    var highlightedStopViewColor: UIColor = Color.Blue.light {
        didSet {
            updateColors()
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            if progress < 0 {
                progress = 0
            } else if progress > 1 {
                progress = 1
            }
            progressCircleView.progress = progress
        }
    }
    
    var stopButtonCornerRadius: CGFloat = 3 {
        didSet {
            stopView.layer.cornerRadius = stopButtonCornerRadius
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateColors()
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Helper methods
    
    private func commonInit() {
        backgroundColor = .clear
        
        addSubview(trackCircleView)
        trackCircleView.pinToSuperview()
        
        addSubview(progressCircleView)
        progressCircleView.pinToSuperview()
        
        addSubview(stopView)
        stopView.centerToSuperview()
        let heightConstraint = stopView.constraint(attribute: .height, toItem: stopView, toAttribute: .width)
        let widthConstraint = stopView.constraint(attribute: .width, toItem: self, toAttribute: .width, multiplier: 0.3, constant: 0)

        NSLayoutConstraint.activate([heightConstraint, widthConstraint])
        updateColors()
    }
    
    private func updateColors() {
        trackCircleView.circleColor = isHighlighted ? highlightedTrackCircleColor : nonhighlightedTrackCircleColor
        progressCircleView.circleColor = isHighlighted ? highlightedProgressCircleColor : nonhighlightedProgressCircleColor
        stopView.backgroundColor = isHighlighted ? highlightedStopViewColor : nonhighlightedStopViewColor
    }
}
