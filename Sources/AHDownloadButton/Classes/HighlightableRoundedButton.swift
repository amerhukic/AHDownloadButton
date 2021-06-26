//
//  HighlightableRoundedButton.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

final class HighlightableRoundedButton: UIButton {
    
    // MARK: Properties
    
    var highlightedBackgroundColor = Color.Gray.light {
        didSet {
            updateColors()
        }
    }
    
    var nonhighlightedBackgroundColor = Color.Gray.medium {
        didSet {
            updateColors()
        }
    }
    
    var highlightedTitleColor = Color.Blue.light {
        didSet {
            updateColors()
        }
    }
    
    var nonhighlightedTitleColor = Color.Blue.medium {
        didSet {
            updateColors()
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
        updateColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateColors()
    }
    
    // MARK: Helper methods

    private func updateColors() {
        backgroundColor = isHighlighted ? highlightedBackgroundColor : nonhighlightedBackgroundColor
        let titleColor = isHighlighted ? highlightedTitleColor : nonhighlightedTitleColor
        setTitleColor(titleColor, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
}
