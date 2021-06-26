//
//  UIButton+TitleWidth.swift
//  AHDownloadButton
//
//  Created by Amer Hukic on 03/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit

extension UIButton {
    
    var titleWidth: CGFloat {
        guard let text = titleLabel?.text, let font = titleLabel?.font else { return 0 }
        return text.size(withAttributes: [.font: font]).width
    }
    
}
