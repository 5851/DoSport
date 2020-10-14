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

    // Набор лого картинки и гостевой вход
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 141).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    private let questButton: UIButton = {
        let button = UIButton(title: "Гостевой вход", background: #colorLiteral(red: 0.319616586, green: 0.5028756261, blue: 1, alpha: 1), isShadow: true)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // Набор textField'o
    private let nameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Имя")
    private let surnameTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Фамилия")
    private let emailTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Адрес эл. почты")
    private let passwordTextField = CustomTextField(cornerRadius: 25, height: 50, fontSize: 20, labelText: "Пароль")

    // Набор согласия на обработку персональных данных
    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel(
            title: "согласие на обработку персональных  данных \n(обязательно для продолжения)",
            height: 50, fontSize: 12)
        return label
    }()

    // Набор ИЛИ и линии
    private let borderLabel: UILabel = {
        let label = CustomAuthLabel(title: "ИЛИ", fontSize: 20, fontWeight: .medium, color: .white)
        return label
    }()
    private let leftBorderView: UIView = {
        let view = CustomBorderAuthView()
        view.backgroundColor = .white
        return view
    }()

    private let rigthBorderView: UIView = {
        let view = CustomBorderAuthView()
        view.backgroundColor = .white
        return view
    }()

    // Набор кнопок регистрации
    private let registrationButton: UIButton = {
        let button = UIButton(title: "Регистрация", background: #colorLiteral(red: 0.9921568627, green: 1, blue: 0.9843137255, alpha: 1), isShadow: true)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()

    private let providerVKontakteRegButton: UIButton = {
        let button = UIButton(titleProvider: "login with Vkontakte", heigth: 50, width: 280, image: #imageLiteral(resourceName: "vk"), fontSize: 18)
        return button
    }()
    private let providerGoogleRegButton: UIButton = {
        let button = UIButton(titleProvider: "login with Google", heigth: 50, width: 280, image: #imageLiteral(resourceName: "google"), fontSize: 18)
        button.setTitle("login with Google", for: .normal)
        return button
    }()
    private let providerFacebookRegButton: UIButton = {
        let button = UIButton(titleProvider: "login with Facebook", heigth: 50, width: 280, image: #imageLiteral(resourceName: "facebook"), fontSize: 18)
        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureUI()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
    }

    // MARK: - Actions
    @objc private func handleRegistration() {
        print(#function)
    }

    @objc private func handleCheckTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = .identity
            })
        })
        if sender.backgroundColor == UIColor.white {
             sender.backgroundColor = UIColor.blue
        } else {
             sender.backgroundColor = UIColor.white
        }
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
        setupViews()
    }

    private func setupViews() {
        //Расположение лого картинки и гостевой вход
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, UIView(), questButton
        ])
        view.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        // Расположение textfield'ов
        let textFieldStackView = UIStackView(arrangedSubviews: [
            nameTextField, surnameTextField, emailTextField, passwordTextField
        ])
        textFieldStackView.axis = .vertical
        view.addSubview(textFieldStackView)
        textFieldStackView.spacing = 15
        textFieldStackView.snp.makeConstraints { (make) in
            make.top.equalTo(topStackView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
        }
        // Расположение объектов согласия на обработку персональных данных
        checkButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
        }

        let centerStackView = UIStackView(arrangedSubviews: [
            checkButton, descriptionLabel
        ])
        centerStackView.spacing = 20
        view.addSubview(centerStackView)
        centerStackView.alignment = .center
        centerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        // Расположение кнопки регистрации
        view.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(centerStackView.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
        }
        // Расположение разделительно линии
        let borderStackView = UIStackView(arrangedSubviews: [
            rigthBorderView, borderLabel, leftBorderView
        ])
        borderStackView.alignment = .center
        borderStackView.distribution = .fillEqually
        view.addSubview(borderStackView)
        borderStackView.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        // Расположение кнопок регистрации
        let registrationStackView = UIStackView(arrangedSubviews: [
            providerVKontakteRegButton,
            providerGoogleRegButton,
            providerFacebookRegButton
        ])
        registrationStackView.axis = .vertical
        registrationStackView.spacing = 20
        view.addSubview(registrationStackView)
        registrationStackView.snp.makeConstraints { (make) in
            make.top.equalTo(borderStackView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
    }
}
