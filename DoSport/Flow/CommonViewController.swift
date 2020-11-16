//
//  CommonViewController.swift
//  DoSport
//
//  Created by MAC on 14.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CommonSettingsViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(colorTop: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }

    // MARK: - Helpers functions
    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
