//
//  UIButton+Extensions.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

extension UIButton {

    func setBackgroundColor(_ color: UIColor, for forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}

extension UIButton {

    convenience init(title: String,
                     isShadow: Bool = false) {
        self.init(type: .system)

        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 25
        setBackgroundColor(#colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1), for: .normal)
        setBackgroundColor(#colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9960784314, alpha: 1), for: .highlighted)
        layer.masksToBounds = true
        setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.halantRegular(size: 18)

        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 16
            self.layer.shadowOffset = CGSize(width: 6, height: 6)
        }
    }
}
