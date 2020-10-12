//
//  UIFont+Extensions.swift
//  DoSport
//
//  Created by MAC on 12.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

extension UIFont {

    static func montserratBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size) ?? UIFont()
    }

    static func halantRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Halant-Regular", size: size) ?? UIFont()
    }
}
