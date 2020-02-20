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
        if let text = titleLabel?.text, let font = titleLabel?.font, !text.isEmpty {
            return text.size(withAttributes: [.font: font]).width
        }else if let image = imageView?.image{
            return image.size.width
        }else {
             return 0
        }
    }
    
}
