//
//  ProgressCircleView.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 17/09/2018.
//

import UIKit

final class ProgressCircleView: UIView {
    
    // MARK: Properties
    
    private let circleView: CircleView = {
        let view = CircleView()
        view.circleColor = .red
        view.startAngleRadians = -CGFloat.pi / 2
        view.endAngleRadians = view.startAngleRadians + 2 * .pi
        return view
    }()
    
    private var isAnimating = false
    
    var progressAnimationDuration: TimeInterval = 0.3
    
    var progress: CGFloat = 0 {
        didSet {
            if progress == 1 && isAnimating {
                if let currentAnimatedProgress = circleView.circleLayer.presentation()?.strokeEnd {
                    circleView.circleLayer.strokeEnd = currentAnimatedProgress
                    animateProgress(from: currentAnimatedProgress, to: progress)
                }
            }
            
            guard !isAnimating else { return }
            animateProgress(from: circleView.circleLayer.strokeEnd, to: progress)
        }
    }
    
    var lineWidth: CGFloat = 1 {
        didSet {
            circleView.lineWidth = lineWidth
        }
    }
    
    var circleColor: UIColor = Color.Blue.medium {
        didSet {
            circleView.circleLayer.strokeColor = circleColor.cgColor
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
    
    private func commonInit() {
        addSubview(circleView)
        circleView.pinToSuperview()
    }
    
    private func animateProgress(from startValue: CGFloat, to endValue: CGFloat) {
        isAnimating = true
        circleView.circleLayer.strokeEnd = endValue
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.fromValue = startValue
        animation.duration = progressAnimationDuration
        animation.delegate = self
        circleView.circleLayer.add(animation, forKey: "strokeEnd")
    }
}

extension ProgressCircleView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimating = !flag
    }
}
