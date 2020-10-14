//
//  UILabel+Extensions.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

extension UILabel {

    convenience init(title: String, height: CGFloat, fontSize: CGFloat) {
        self.init()
        text = title
        textAlignment = .center
        numberOfLines = 0
        textColor = .white
        font = UIFont.halantRegular(size: fontSize)
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        layer.cornerRadius = height / 2
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 2
    }
}
