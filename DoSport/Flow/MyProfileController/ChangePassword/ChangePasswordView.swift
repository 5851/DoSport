//
//  ChangePasswordView.swift
//  DoSport
//
//  Created by Sergey on 21.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordView: UIView {

    // MARK: - OUTLETS
    private let oldPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 18, labelText: "Старый пароль")
        return textField
    }()
    private let newPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 18, labelText: "Новый пароль")
        return textField
    }()
    private let infoNewPasswordTextField: UILabel = {
        let label = UILabel(title: "Введите новый пароль еще раз", height: 22, fontSize: 14)
        label.layer.borderWidth = 0
        return label
    }()
    private let retypeNewPasswordTextField: CustomTextField = {
        let textField = CustomTextField(cornerRadius: 20, height: 40, fontSize: 18, labelText: "Новый пароль")
        return textField
    }()
    private let savePasswordButton: UIButton = {
        let button = UIButton(titleProvider: "Сохранить", heigth: 50, width: 134, fontSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8980392157, blue: 1, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.3370614648, green: 0.5302922726, blue: 1, alpha: 1), for: .normal)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveFullInfoAction), for: .touchUpInside)
        return button
    }()
    let closeViewButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewAction), for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func saveFullInfoAction(sender: UIButton) {
    }
    @objc func closeViewAction() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
        removeFromSuperview()
    }
    // MARK: - SetupUI
    func setupUI() {
        addSubview(oldPasswordTextField)
        addSubview(newPasswordTextField)
        addSubview(infoNewPasswordTextField)
        addSubview(retypeNewPasswordTextField)
        addSubview(savePasswordButton)
        addSubview(closeViewButton)
        backgroundColor = #colorLiteral(red: 0.4332328439, green: 0.5891472101, blue: 1, alpha: 1)
        layer.cornerRadius = 10

        oldPasswordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(230)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(92)
        }
        newPasswordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(oldPasswordTextField.snp.width)
            make.top.equalTo(oldPasswordTextField.snp.bottom).offset(20)
            make.leading.equalTo(oldPasswordTextField.snp.leading)
        }
        infoNewPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(42)
            make.centerX.equalTo(self.snp.centerX)
        }
        retypeNewPasswordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(oldPasswordTextField.snp.width)
            make.top.equalTo(infoNewPasswordTextField.snp.bottom).offset(14)
            make.leading.equalTo(oldPasswordTextField.snp.leading)
        }
        savePasswordButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(oldPasswordTextField.snp.centerX)
            make.top.equalTo(retypeNewPasswordTextField.snp.bottom).offset(35)
        }
        closeViewButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(oldPasswordTextField.snp.top).offset(-32)
            make.trailing.equalTo(oldPasswordTextField.snp.trailing)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    // MARK: - HelpersFunctions
    func drawCross() { // не используется
        let crossPath = UIBezierPath()
        let crossShapeLayer = CAShapeLayer()
        crossPath.lineWidth = 3.0
        crossPath.move(to: CGPoint(x: closeViewButton.bounds.minX, y: closeViewButton.bounds.minY))
        crossPath.addLine(to: CGPoint(x: closeViewButton.bounds.maxX, y: closeViewButton.bounds.maxY))
        crossPath.move(to: CGPoint(x: closeViewButton.bounds.minX, y: closeViewButton.bounds.maxY))
        crossPath.addLine(to: CGPoint(x: closeViewButton.bounds.maxX - bounds.maxX / 2, y: closeViewButton.bounds.minY))
        crossShapeLayer.path = crossPath.cgPath
        crossShapeLayer.fillColor = UIColor.white.cgColor
        crossShapeLayer.lineWidth = 3.0
        UIColor.white.setStroke()
        crossPath.stroke()
        closeViewButton.layer.addSublayer(crossShapeLayer)
    }
}
