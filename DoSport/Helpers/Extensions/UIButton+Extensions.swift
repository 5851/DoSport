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
                     background: UIColor,
                     isShadow: Bool = false) {
        self.init(type: .system)

        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 25
        backgroundColor = background
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.halantRegular(size: 18)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.4
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
        }
    }
}

extension UIButton {

    convenience init(titleProvider: String,
                     heigth: CGFloat,
                     width: CGFloat,
                     image: UIImage,
                     fontSize: CGFloat,
                     isShadow: Bool = false) {
        self.init(type: .system)

        setTitle(titleProvider, for: .normal)
        titleLabel?.font = UIFont.halantRegular(size: fontSize)
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        layer.cornerRadius = heigth / 2
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1)
        layer.masksToBounds = true

        configureButtonUI(width: width, height: heigth)

        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 16
            self.layer.shadowOffset = CGSize(width: 10, height: 10)
        }
    }

    private func configureButtonUI(width: CGFloat, height: CGFloat) {
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 70)
        imageView?.snp.makeConstraints({ (make) in
            make.trailing.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
    }
}

extension UIButton {

    convenience init(titleProvider: String,
                     heigth: CGFloat,
                     width: CGFloat,
                     fontSize: CGFloat,
                     isShadow: Bool = false) {
        self.init()

        setTitle(titleProvider, for: .normal)
        titleLabel?.font = UIFont.halantRegular(size: fontSize)
        layer.cornerRadius = heigth / 2
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1)
//        layer.masksToBounds = true

        configureButton(width: width, height: heigth)

        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 16
            self.layer.shadowOffset = CGSize(width: 10, height: 10)
        }
    }

    private func configureButton(width: CGFloat, height: CGFloat) {
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
}

class EditButton: UIButton {
    convenience init(width: CGFloat, hight: CGFloat) {
        self.init(type: .custom)
//        backgroundColor = .white
        setImage(#imageLiteral(resourceName: "edit_pen"), for: .normal)
        self.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(hight)
        }
    }
}

class ChangePasswordBtn : UIButton {
    convenience init(titleProvider: String,
                     heigth: CGFloat,
                     width: CGFloat,
                     fontSize: CGFloat) {
        self.init()
        
        setTitle(titleProvider, for: .normal)
        titleLabel?.font = UIFont.halantRegular(size: fontSize)
        layer.cornerRadius = heigth / 2
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1)
        configureButton(width: width, height: heigth)
    }
    private func configureButton(width: CGFloat, height: CGFloat) {
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    override func draw(_ rect: CGRect) {
        let arrowPath = UIBezierPath()
        arrowPath.lineWidth = 3.0
        arrowPath.move(to: CGPoint(x:bounds.maxX - bounds.maxY / 2,y: bounds.maxY))
        arrowPath.addLine(to: CGPoint(x: bounds.maxX,y: bounds.height / 2))
        arrowPath.addLine(to: CGPoint(x: bounds.maxX - bounds.maxY / 2, y: bounds.minY))
        UIColor.white.setStroke()
        arrowPath.stroke()
    }
}
