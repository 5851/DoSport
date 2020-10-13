//
//  UserModel.swift
//  DoSport
//
//  Created by MAC on 13.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Outlets
    private let nameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 22, labelText: "Имя")
    private let surnameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 22, labelText: "Фамилия")
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 22, labelText: "Адрес эл. почты")
    private let passwordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 22, labelText: "Пароль")
    private let registrationButton: UIButton = {
        let button = UIButton(title: "Начать", isShadow: true)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
    }

    // MARK: - Actions
    @objc private func handleRegistration() {
        print(#function)
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

// MARK: - Setup UI
extension LoginViewController {
    private func configureUI() {
        view.backgroundColor = .white

        let textFieldStackView = UIStackView(arrangedSubviews: [
            nameTextField, surnameTextField, emailTextField, passwordTextField
        ])
        textFieldStackView.axis = .vertical
        view.addSubview(textFieldStackView)
        textFieldStackView.spacing = 15
        textFieldStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
        }
    }
}
