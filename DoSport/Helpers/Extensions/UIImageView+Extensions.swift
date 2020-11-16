//
//  UIImageView+Extensions.swift
//  DoSport
//
//  Created by MAC on 15.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
