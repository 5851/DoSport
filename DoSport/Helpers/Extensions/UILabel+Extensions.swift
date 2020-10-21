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
        self.text = title
        self.textAlignment = .center
        self.numberOfLines = 0
        self.textColor = .white
        self.font = UIFont.halantRegular(size: fontSize)
        self.layer.masksToBounds = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.layer.cornerRadius = height / 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 2
    }
}

extension UILabel {

    convenience init(title: String,
                     textAlignment: NSTextAlignment,
                     textColor: UIColor,
                     numberOfLines: Int,
                     fontSize: CGFloat) {
        self.init()
        self.textAlignment = textAlignment
        self.text = title
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.font = UIFont.halantRegular(size: fontSize)
    }
}
