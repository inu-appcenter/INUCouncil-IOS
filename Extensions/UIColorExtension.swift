//
//  UIColorExtension.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(ored: CGFloat, ogreen: CGFloat, oblue: CGFloat, alpha: CGFloat) {
        self.init(red: ored/255,
                  green: ogreen/255,
                  blue: oblue/255,
                  alpha: alpha)
    }
    
    struct INUnionColor {
        struct ThemeColor {
            static let NavigationColor = UIColor.init(ored: 59, ogreen: 91, oblue: 219, alpha: 1)
            static let MainColor = UIColor.init(ored: 76, ogreen: 110, oblue: 245, alpha: 1)
            static let SearchbarColor = UIColor.init(ored: 66, ogreen: 100, oblue: 235, alpha: 1)
            static let ShadowColor = UIColor.init(ored: 189, ogreen: 189, oblue: 189, alpha: 1)
        }
    }
}

